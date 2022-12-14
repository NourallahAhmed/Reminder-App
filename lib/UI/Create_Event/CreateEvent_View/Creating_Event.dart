import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:todo_list/Services/Notifications/Notification_Api.dart';
import 'package:todo_list/Services/Provider/MyProvider.dart';

import 'package:provider/provider.dart';
import 'package:todo_list/UI/HomePage/home_page.dart';
import 'package:intl/intl.dart';

// import 'package:geocoder/geocoder.dart';
import 'package:google_maps_webservice/places.dart';

import '../../ToDo_List/ToDo_List.dart';

class Creating_Event extends StatefulWidget {
  // final Function() notifyParent;

  final DateTime selectedDay;

  const Creating_Event({
    Key? key,
    required this.selectedDay,
    /*required this.notifyParent*/
  }) : super(key: key);

  @override
  State<Creating_Event> createState() => _Creating_EventState(selectedDay);
}

class _Creating_EventState extends State<Creating_Event> {
  final _formKey = GlobalKey<FormState>();

  // final kGoogleApiKey = "AIzaSyDC2Xz1DDx81Hu5MmCYR6XnEybSNF3YXcE";
  var taskDesc = TextEditingController();
  var taskSummary = TextEditingController();
  var taskIsDone = TextEditingController();
  var taskStartTime = TextEditingController();
  var taskEndTime = TextEditingController();
  var taskLocation = TextEditingController();
  var taskURL = TextEditingController();

  var taskIsAllDay = false;
  var taskIsOnline = false;

  Color selectedColor = Colors.blueAccent;

  late final CleanCalendarEvent event;

  DateTime selectedDay;

  var _selectedIndex = 1;

  //MARK: NEW TIME PICKER

  TimeOfDay _startTime = TimeOfDay(hour: 7, minute: 15);
  TimeOfDay _endTime = TimeOfDay(hour: 7, minute: 15);

  //todo change to 5:00 pm format
  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  void _selectTime(int num) async {
    if (num == 2) {
      final TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: _endTime,
      );

      if (newTime != null) {
        setState(() {
          _endTime = newTime;
          print(_endTime);
        });
      }
    } else {
      final TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: _startTime,
      );

      if (newTime != null) {
        setState(() {
          _startTime = newTime;
          print(_startTime);
        });
      }
    }
  }

  _Creating_EventState(this.selectedDay);

  initState() {
    Notification_Api.init();
    listenNotifictions();
  }

  void listenNotifictions() {
    Notification_Api.onNotifications.stream.listen(onClickedNotification);
  }

  void onClickedNotification(String? payload) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Create new Events"),
            backgroundColor: Colors.blueAccent,
            actions: [
              IconButton(onPressed: (){if (_formKey.currentState!.validate()) {
                print("condition");
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );

                event = CleanCalendarEvent(
                    UniqueKey().hashCode, taskSummary.text,
                    startTime: DateTime(
                      selectedDay.year,
                      selectedDay.month,
                      selectedDay.day,
                      _startTime.hour,
                      _startTime.minute,
                    ),
                    endTime: DateTime(
                      selectedDay.year,
                      selectedDay.month,
                      selectedDay.day,
                      _endTime.hour,
                      _endTime.minute,
                    ));

                event.description = taskDesc.text;

                event.location = taskLocation.text;
                event.isAllDay = taskIsAllDay;
                event.color = selectedColor;
                event.Url = taskURL.text;
                event.isOnline = taskIsOnline;
                print(event.startTime);
                print(event.endTime);
                Provider.of<MyProvider>(context, listen: false)
                    .insertEvent(event);

                //todo: notifiction

                // Notification_Api.showNotification(
                //     title: event.description,
                //     body: "${DateFormat.yMMMMd().format(event.startTime).toString()} \n ${event.summary}",
                //     payload: DateFormat.yMMMMd().format(event.startTime).toString());




                Notification_Api.showScheduleNotification(
                    title: event.description,
                    body:""" ${event.summary}  from ${event.startTime.hour}:${event.startTime.minute} to   ${event.endTime.hour}:${event.endTime.minute} """
                    ,
                    payload: DateFormat.yMMMMd()
                        .format(event.startTime)
                        .toString(),
                    shcedauleDate: event.startTime);
              }
              print("test");
              // widget.notifyParent;
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MyHomePage()));
              }, icon: Icon(Icons.check ,color: Colors.white,))
            ],
          ),
          body: Container(
            height: double.infinity,
            decoration: BoxDecoration(
                // border: Bord(color: Colors.lightBlueAccent),
                // borderRadius: const BorderRadius.all(Radius.circular(10)),
                gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                  Colors.blueAccent.withOpacity(0.0),
                  Colors.white,
                ],
                    stops: const [
                  0.0,
                  1.0
                ])
                // color: Colors.blueAccent.shade200
                ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ///   TITLE
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Create New Event   ",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        RotationTransition(
                          turns: const AlwaysStoppedAnimation(15 / 360),
                          child: Image.network(
                            "https://cdn-icons-png.flaticon.com/512/2421/2421284.png",
                            height: 90,
                            width: 90,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// Description
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Fill this Feild';
                        }
                        return null;
                      },

                      decoration: const InputDecoration(
                        //90CAF9FF
                        fillColor: Colors.blueAccent,
                        //.fromARGB(09,56, 79, 98)  ,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(color: Colors.blueAccent, width: 1)),
                        hintText: "Description",
                        prefixIcon: Icon(
                          Icons.description,
                          color: Colors.blueAccent,
                        ),
                      ),
                      controller: taskDesc,
                    ),
                  ),

                  /// Summary
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Fill this Feild';
                        }
                        return null;
                      },

                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(color: Colors.blueAccent, width: 1)),
                        hintText: "Summary",
                        prefixIcon: Icon(
                          Icons.description,
                          color: Colors.blueAccent,
                        ),
                      ),
                      controller: taskSummary,
                    ),
                  ),

                  /// IS Online
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.blueAccent, width: 1.0),
                        borderRadius: const BorderRadius.all(Radius.circular(
                                10.0) //                 <--- border radius here
                            ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "\t \t Is it online : ",
                            style: TextStyle(
                                color: Colors.blueAccent, fontSize: 20),
                          ),
                          Checkbox(
                            checkColor: Colors.blueAccent,
                            activeColor: Colors.white,
                            value: taskIsOnline,
                            onChanged: (value) {
                              setState(() {
                                taskIsOnline
                                    ? taskIsOnline = false
                                    : taskIsOnline = true;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  //todo if it online feild to add the link of meeting
                  /// Location
                  taskIsOnline
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            keyboardType: TextInputType.url,
                            decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent, width: 1)),
                              hintText: "https://www.google.com/",
                              // labelText: IsEditable ? widget.event.location : "",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              prefixIcon:
                                  Icon(Icons.map, color: Colors.blueAccent),
                            ),
                            controller: taskURL,
                          ),
                        )
                      : Container(),

                  /// Location
                  taskIsOnline
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent, width: 1)),
                              hintText: "location",
                              // labelText: IsEditable ? widget.event.location : "",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              prefixIcon:
                                  Icon(Icons.map, color: Colors.blueAccent),
                            ),
                            controller: taskLocation,
                          ),
                        ),

                  /// TODO: IS ALL DAY
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.blueAccent, width: 1.0),
                        borderRadius: const BorderRadius.all(Radius.circular(
                                10.0) //                 <--- border radius here
                            ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "\t \t Is All Day : ",
                            style: TextStyle(
                                color: Colors.blueAccent, fontSize: 20),
                          ),
                          Checkbox(
                            checkColor: Colors.blueAccent,
                            activeColor: Colors.white,
                            value: taskIsAllDay,
                            onChanged: (value) {
                              setState(() {
                                taskIsAllDay
                                    ? taskIsAllDay = false
                                    : taskIsAllDay = true;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// TODO: Time

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.blueAccent, width: 1.0),
                        borderRadius: const BorderRadius.all(Radius.circular(
                                10.0) //                 <--- border radius here
                            ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  const Text("\t Start Time ",
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 15)),
                                  IconButton(
                                      onPressed: () => _selectTime(1),
                                      icon: const Icon(
                                        Icons.timer,
                                        color: Colors.blueAccent,
                                      ))
                                ],
                              ),
                              Text(formatTimeOfDay(_startTime),
                                  style: const TextStyle(
                                      color: Colors.black54, fontSize: 15)),
                            ],
                          ),
                          Column(children: [
                            Row(
                              children: [
                                const Text(
                                  "\t End Time ",
                                  style: TextStyle(
                                      color: Colors.blueAccent, fontSize: 15),
                                ),
                                IconButton(
                                    onPressed: () => _selectTime(2),
                                    icon: const Icon(
                                      Icons.timer,
                                      color: Colors.blueAccent,
                                    ))
                              ],
                            ),
                            Text(formatTimeOfDay(_endTime),
                                style: const TextStyle(
                                    color: Colors.black54, fontSize: 15))
                          ])
                        ],
                      ),
                    ),
                  ),

                  //TODO: priority
                  Container(
                    // padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                    // alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      // color: Colors.blueAccent.shade200
                    ),
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Priority: ",
                            style: TextStyle(
                                color: Colors.blueAccent, fontSize: 20)),
                        OutlinedButton(
                          autofocus: false,
                          onPressed: () {
                            selectedColor = Colors.red;
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                // <-- Icon
                                Icons.circle,
                                size: 24.0,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('High'), // <-- Text
                            ],
                          ),
                        ),
                        OutlinedButton(
                          autofocus: false,
                          onPressed: () {
                            selectedColor = Colors.blueAccent;
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                // <-- Icon
                                Icons.circle,
                                size: 24.0,
                                color: Colors.blueAccent,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Normal'), // <-- Text
                            ],
                          ),
                        ),
                        OutlinedButton(
                          autofocus: false,
                          onPressed: () {
                            selectedColor = Colors.yellow;
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                // <-- Icon
                                Icons.circle,
                                size: 24.0,
                                color: Colors.yellow,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Low'), // <-- Text
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: Colors.blueAccent,
            index: 1,
            items: const <Widget>[
              Icon(Icons.home, size: 30),
              Icon(Icons.add, size: 30),
              Icon(Icons.list_alt, size: 30),
            ],
            onTap: _onItemTapped,
          ),
        ));
  }

  void _onItemTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });

    switch (_selectedIndex) {
      case 0:
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MyHomePage()));
        break;

      case 1:
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) =>
        //             Creating_Event(selectedDay: selectedDay)));
        break;
      case 2:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ToDo_List()));
        break;
    }
  }
}
