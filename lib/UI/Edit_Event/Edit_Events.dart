import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:todo_list/Services/Provider/MyProvider.dart';

import 'package:provider/provider.dart';

import '../HomePage/home_page.dart';
import 'package:intl/intl.dart';

class Edit_Event extends StatefulWidget {

  final CleanCalendarEvent event;

  final DateTime selectedDay;

  const Edit_Event(
      {Key? key, required this.selectedDay, required this.event})
      : super(key: key);

  @override
  State<Edit_Event> createState() => _Edit_EventState(selectedDay , event );
}

class _Edit_EventState extends State<Edit_Event> {
  final _formKey = GlobalKey<FormState>();

  var taskDesc = TextEditingController();
  var taskSummary = TextEditingController();
  var taskIsDone = TextEditingController();
  var taskStartTime = TextEditingController();
  var taskEndTime = TextEditingController();
  var taskLocation = TextEditingController();

  var taskURL= TextEditingController();

  var taskIsAllDay = false;
  var taskIsOnline = false;


  Color selectedColor = Colors.blue;

  late final CleanCalendarEvent event;

  DateTime selectedDay ;

  //MARK: NEW TIME PICKER

  TimeOfDay _startTime = TimeOfDay(hour: 7, minute: 15);
  TimeOfDay _endTime = TimeOfDay(hour: 7, minute: 15);

  //todo change to 5:00 pm format
  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm();  //"6:00 AM"
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


  _Edit_EventState(this.selectedDay , this.event);

initState(){

  setState(() {
    this.taskIsOnline = widget.event.isOnline;
    // this.taskURL = widget.event.Url as TextEditingController;
    // this.taskDesc = widget.event.description as TextEditingController;
    // this.taskLocation = widget.event.location as TextEditingController;
  });
}


  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(title:  Text(event.description)),
          body: Container(
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Colors.blue.withOpacity(0.0),
                      Colors.white,
                    ],
                    stops: const [
                      0.0,
                      1.0
                    ])
              // color: Colors.blue.shade200
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ///   todo: TITLE
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                         Text(
                          event.description,
                          style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),

                        SizedBox(
                          width: 20,
                        ),
                        RotationTransition(
                          turns: const AlwaysStoppedAnimation(15 / 360),
                          child: Image.network(
                            "https://cdn-icons-png.flaticon.com/512/2421/2421284.png",
                            height: 50,
                            width: 50,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// todo: Description
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

                      decoration:  InputDecoration(
                        //90CAF9FF
                        fillColor: Colors.blue, //.fromARGB(09,56, 79, 98)  ,
                        enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                            BorderSide(color: Colors.blueAccent, width: 1)),
                        hintText: event.description,
                        prefixIcon:  const Icon(
                          Icons.description,
                          color: Colors.blue,
                        ),
                      ),
                      controller: taskDesc,
                    ),
                  ),

                  /// todo: Summary
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

                      decoration:  InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                            BorderSide(color: Colors.blueAccent, width: 1)),
                        hintText: event.summary,
                        prefixIcon: const Icon(
                          Icons.description,
                          color: Colors.blue,
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
                            style: TextStyle(color: Colors.blue, fontSize: 20),
                          ),
                          Checkbox(
                            checkColor: Colors.blue,
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
                  taskIsOnline ?
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      keyboardType: TextInputType.url,
                      decoration: const InputDecoration(
                        enabledBorder:   OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                            BorderSide(color: Colors.blueAccent, width: 1)),
                        hintText: "URL For the  online meeting",
                        // labelText: IsEditable ? widget.event.location : "",
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        prefixIcon: Icon(Icons.map, color: Colors.blue),
                      ),
                      controller: taskURL,
                    ),
                  ) : Container() ,



                  /// Location
                  taskIsOnline ? Container() :
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: const InputDecoration(
                        enabledBorder:   OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                            BorderSide(color: Colors.blueAccent, width: 1)),
                        hintText: "location",
                        // labelText: IsEditable ? widget.event.location : "",
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        prefixIcon: Icon(Icons.map, color: Colors.blue),
                      ),
                      controller: taskLocation,
                    ),
                  ),

                  /// todo: IS ALL DAY
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
                            style: TextStyle(color: Colors.blue , fontSize: 20) ,
                          ),
                          Checkbox(
                            checkColor: Colors.blue,
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

                  //todo: day picker
                  Padding(
                    padding: const EdgeInsets.all(8.0),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          "Day: ",
                          style: TextStyle(color: Colors.black54 , fontSize: 20) ,
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          decoration: BoxDecoration(
                            border:
                            Border.all(color: Colors.blueAccent, width: 1.0),
                            borderRadius: const BorderRadius.all(Radius.circular(
                                10.0) //                 <--- border radius here
                            ),
                          ),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment,
                            children: [

                              Text(
                                "  ${selectedDay}",
                                style: TextStyle(color: Colors.black54 , fontSize: 20) ,
                              ),
                              IconButton(
                                icon:  Icon(Icons.date_range),
                                onPressed: () async {

                                 var selectedDay2 = (await showDatePicker(context: context, initialDate: DateTime(event.startTime.year , event.startTime.month , event.startTime.day),
                                      firstDate: DateTime(event.startTime.year , event.startTime.month , event.startTime.day),

                                      lastDate: DateTime(2025 , event.startTime.month , event.startTime.day)))!;
                                 setState(() {
                                    selectedDay = selectedDay2;
                                 });


                                },
                              )
                            ],
                          ),
                        ),
                      ],
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
                                          color: Colors.blue, fontSize: 15)),
                                  IconButton(
                                      onPressed: () => _selectTime(1),
                                      icon: const Icon(
                                        Icons.timer,
                                        color: Colors.blue,
                                      ))
                                ],
                              ),
                              Text(formatTimeOfDay(_startTime) ,
                                  style: const TextStyle(
                                      color: Colors.black54, fontSize: 15)),
                            ],
                          ),
                          Column(children: [
                            Row(
                              children: [
                                const  Text(
                                  "\t End Time ",
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 15),
                                ),
                                IconButton(
                                    onPressed: () => _selectTime(2),
                                    icon: const Icon(
                                      Icons.timer,
                                      color: Colors.blue,
                                    ))
                              ],
                            ),
                            Text(formatTimeOfDay(_endTime) ,
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
                      // color: Colors.blue.shade200
                    ),
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Priority: ",
                            style: TextStyle(color: Colors.blue, fontSize: 20)),
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
                            selectedColor = Colors.blue;
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                // <-- Icon
                                Icons.circle,
                                size: 24.0,
                                color: Colors.blue,
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

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),

                    child: ElevatedButton(
                      style: ButtonStyle(

                      ),
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   const SnackBar(content: Text('Processing Data')),
                          // );



                          Provider.of<MyProvider>(context , listen : false).deleteEvent(event);
                          print("DONE1");




                         var newEvent = CleanCalendarEvent(

                              UniqueKey().hashCode,
                              taskSummary.text,
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
                             ),
                           description: taskDesc.text,
                           location: taskLocation.text,
                           isAllDay: taskIsAllDay,

                           Url : taskURL.text,
                           isOnline: taskIsOnline ,
                          color :selectedColor,
                         );

                          print("DONE2");

                          Provider.of<MyProvider>(context , listen : false).insertEvent(newEvent);
                          print("DONE3");

                          Navigator.push(context, MaterialPageRoute(builder: (builder) => MyHomePage()));

                        }
                      }
                      ,
                      child: const Text('Edit'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

}
