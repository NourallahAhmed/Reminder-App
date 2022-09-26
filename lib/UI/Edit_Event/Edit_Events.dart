import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:todo_list/Services/Provider/MyProvider.dart';

import 'package:provider/provider.dart';

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
  var hourSelected_Start = TextEditingController();
  var minSelected_Start = TextEditingController();

  var hourSelected_End = TextEditingController();
  var minSelected_End = TextEditingController();
  var taskLocation = TextEditingController();

  var taskIsAllDay = false;

  Color selectedColor = Colors.blue;

  late final CleanCalendarEvent event;

  DateTime selectedDay;

  //MARK: TimePicker

  var isAM_Start = false;
  var isPM_Start = false;

  var isAM_End = false;
  var isPM_End = false;

  _Edit_EventState(this.selectedDay , this.event);




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

                  /// todo: Location
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration:  InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                            BorderSide(color: Colors.blueAccent, width: 1)),
                        hintText: event.location.isEmpty ? "location" : event.location,
                        // labelText: IsEditable ? widget.event.location : "",
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        prefixIcon: const Icon(
                          Icons.location_city,
                          color: Colors.blue,
                        ),
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
                            "Day: ",
                            style: TextStyle(color: Colors.blue , fontSize: 20) ,
                          ),
                          Text(
                            "${DateTime(event.startTime.year , event.startTime.month , event.startTime.day)}",
                            style: TextStyle(color: Colors.blue , fontSize: 20) ,
                          ),

                          IconButton(
                            icon:  Icon(Icons.date_range),
                            onPressed: () async {
                              selectedDay = (await showDatePicker(context: context, initialDate: DateTime(event.startTime.year , event.startTime.month , event.startTime.day),

                                  firstDate: DateTime(event.startTime.year , event.startTime.month , event.startTime.day),

                                  lastDate: DateTime(2025 , event.startTime.month , event.startTime.day)))!;



                            },
                          )

                        ],
                      ),
                    ),
                  ),

                  /// todo: Start Time
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                      decoration: BoxDecoration(
                        border:
                        Border.all(color: Colors.blueAccent, width: 1.0),
                        borderRadius: const BorderRadius.all(Radius.circular(
                            10.0) //                 <--- border radius here
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              Text(
                                "\t Start Time",
                                style: TextStyle(color: Colors.blue ,fontSize:  20 ),
                              ),
                              Icon(
                                Icons.timer,
                                color: Colors.blue,
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              /// HR
                              Flexible(
                                child: TextFormField(
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Fill this Feild';
                                    }
                                    return null;
                                  },

                                  maxLength: 2,
                                  decoration:  InputDecoration(
                                      isDense: true,
                                      contentPadding: const EdgeInsets.all(4),
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(width: 2)),
                                      hintText: "${event.startTime.hour}",
                                      labelText: "hr"),
                                  controller: hourSelected_Start,
                                  keyboardType: TextInputType.number,
                                ),
                              ),

                              /// MIN
                              Flexible(
                                child: TextFormField(
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Fill this Feild';
                                    }
                                    return null;
                                  },

                                  maxLength: 2,
                                  decoration:  InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(4),
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(width: 2)),
                                      hintText: "${event.startTime.minute}",
                                      labelText: "min"),
                                  controller: minSelected_Start,
                                  keyboardType: TextInputType.number,
                                ),
                              ),

                              /// AM / PM
                              Flexible(
                                  child: Column(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            if (isAM_Start) {
                                              isAM_Start = false;
                                              isPM_Start = true;
                                            } else {
                                              isAM_Start = true;
                                              isPM_Start = false;
                                            }
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: isAM_Start
                                              ? Colors.blue.shade200
                                              : Colors.grey,
                                        ),
                                        child: const Text("AM",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              if (isPM_Start) {
                                                isPM_Start = false;
                                                isAM_Start = true;
                                              } else {
                                                isAM_Start = false;
                                                isPM_Start = true;
                                              }
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: isPM_Start
                                                ? Colors.blue.shade200
                                                : Colors.grey,
                                          ),
                                          child: const Text("PM",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold))),
                                    ],
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// todo: End Time

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
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              Text(
                                "\t End Time",
                                style: TextStyle(color: Colors.blue , fontSize: 20),
                              ),
                              Icon(
                                Icons.timer,
                                color: Colors.blue,
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              /// HR
                              Flexible(
                                child: TextFormField(
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Fill this Feild';
                                    }
                                    return null;
                                  },

                                  maxLength: 2,
                                  decoration:  InputDecoration(
                                      isDense: true,
                                      contentPadding:const EdgeInsets.all(4),
                                      border:const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(width: 2)),
                                      hintText: "${event.endTime.hour}",
                                      labelText: "hr"),
                                  controller: hourSelected_End,
                                  keyboardType: TextInputType.number,
                                ),
                              ),

                              /// MIN
                              Flexible(
                                child: TextFormField(
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Fill this Feild';
                                    }
                                    return null;
                                  },

                                  maxLength: 2,
                                  decoration:  InputDecoration(
                                      isDense: true,
                                      contentPadding: const EdgeInsets.all(4),
                                      border:const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(width: 2)),
                                      hintText: "${event.endTime.hour}",
                                      labelText: "min"),
                                  controller: minSelected_End,
                                  keyboardType: TextInputType.number,
                                ),
                              ),

                              /// AM / PM
                              Flexible(
                                  child: Column(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            if (isAM_End) {
                                              isAM_End = false;
                                              isPM_End = true;
                                            } else {
                                              isAM_End = true;
                                              isPM_End = false;
                                            }
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: isAM_End
                                              ? Colors.blue.shade200
                                              : Colors.grey,
                                        ),
                                        child: const Text("AM",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              if (isPM_End) {
                                                isPM_End = false;
                                                isAM_End = true;
                                              } else {
                                                isAM_End = false;
                                                isPM_End = true;
                                              }
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: isPM_End
                                                ? Colors.blue.shade200
                                                : Colors.grey,
                                          ),
                                          child: const Text("PM",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold))),
                                    ],
                                  ))
                            ],
                          ),
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
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );

                          event = CleanCalendarEvent(

                              UniqueKey().hashCode,
                              taskSummary.text,
                              startTime: DateTime(
                                  selectedDay.year,
                                  selectedDay.month,
                                  selectedDay.day,
                                  int.parse(
                                      isAM_Start ?    int.parse(hourSelected_Start.text) == 12 ? "00" :  hourSelected_Start.text :
                                      int.parse(hourSelected_Start.text) < 12 ?
                                      (int.parse(hourSelected_Start.text) + 12).toString() : hourSelected_End.text

                                  ),
                                  int.parse(minSelected_Start.text)),
                              endTime: DateTime(
                                  selectedDay.year,
                                  selectedDay.month,
                                  selectedDay.day,
                                  int.parse(
                                      isAM_End ?    int.parse(hourSelected_End.text) == 12 ? "00" : hourSelected_End.text :
                                      int.parse(hourSelected_End.text) < 12 ?
                                      (int.parse(hourSelected_End.text) + 12).toString() : hourSelected_End.text

                                  ),
                                  int.parse(minSelected_End.text)));

                          event.description = taskDesc.text;

                          event.location = taskLocation.text;
                          event.isAllDay = taskIsAllDay;
                          event.color = selectedColor;

                          Provider.of<MyProvider>(context , listen : false).editEvent(event);
                          // DBHelper.insertEvent(event);
                        }


                        Navigator.pop(context);
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
