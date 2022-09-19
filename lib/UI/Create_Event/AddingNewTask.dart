// import 'package:flutter/material.dart';
// import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
// import 'package:todo_list/CustomTimePickerWidget/TimePickerWidget.dart';
// import 'package:todo_list/HomePage/home_page.dart';
//
// class AddingNewTask extends StatefulWidget {
//
//   final Function() notifyParent;
//
//   final DateTime selectedDay;
//
//   const AddingNewTask({Key? key, required this.selectedDay , required this.notifyParent}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() => _AddingNewTaskState(selectedDay);
// }
//
// class _AddingNewTaskState extends State<AddingNewTask> {
//   var taskDesc = TextEditingController();
//   var taskSummary = TextEditingController();
//   var taskIsDone = TextEditingController();
//   var taskStartTime = TextEditingController();
//   var taskEndTime = TextEditingController();
//
//   var taskIsAllDay = false;
//
//   var taskLocation = TextEditingController();
//   var TimePickerWidgetStartTime = TimePickerWidget(
//     title: "Start Time",
//   );
//   var TimePickerWidgetEndTime = TimePickerWidget(
//     title: "End Time",
//   );
//
//   Color selectedColor = Colors.blue;
//
//   late final CleanCalendarEvent event;
//
//   DateTime selectedDay;
//
//   //MARK: TimePicker
//
//   _AddingNewTaskState(this.selectedDay);
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("Create new task"),
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//         ),
//         body: Container(
//           height: double.infinity,
//
//           // padding: const EdgeInsets.all(50.0),
//           margin: const EdgeInsets.fromLTRB(0, 20.0, 0, 0),
//           child: SingleChildScrollView(
//             child: Column(
//               // mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 //TODO: PageTitle
//                 Column(
//                   children: [
//                     // Image.asset("assets/images/image_e.png"),
//
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text(
//                           "Create New Task ",
//                           style: TextStyle(
//                               color: Colors.blue,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         Image.network(
//                           "https://images-na.ssl-images-amazon.com/images/I/31RvOPlfH7L.png",
//                           height: 60,
//                           width: 60,
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 25,
//                     )
//                   ],
//                 ),
//
//                 //TODO: Description
//
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                   // decoration: BoxDecoration(
//                   //     border: Border.all(color: Colors.blueAccent) ,
//                   //     borderRadius : BorderRadius.all(Radius.circular(10)),
//                   //   color: Colors.blue.shade200
//                   // ),
//                   child: SizedBox(
//                       width: 250,
//                       height: 100,
//                       child: TextField(
//                         decoration: const InputDecoration(
//                           //90CAF9FF
//                           fillColor: Colors.blue, //.fromARGB(09,56, 79, 98)  ,
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(10)),
//                               borderSide: BorderSide(
//                                   color: Colors.blueAccent, width: 1)),
//                           hintText: "Description",
//                           prefixIcon: Icon(
//                             Icons.description,
//                             color: Colors.blue,
//                           ),
//                         ),
//                         controller: taskDesc,
//                       )),
//                 ),
//
//                 //TODO: Summary
//
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                   child: SizedBox(
//                       width: 250,
//                       height: 100,
//                       child: TextField(
//                         decoration: const InputDecoration(
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(10)),
//                               borderSide: BorderSide(
//                                   color: Colors.blueAccent, width: 1)),
//                           hintText: "Summary",
//                           prefixIcon: Icon(
//                             Icons.description,
//                             color: Colors.blue,
//                           ),
//                         ),
//                         controller: taskSummary,
//                       )),
//                 ),
//
//                 //TODO: Location  --> USE MAP
//
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                   child: SizedBox(
//                       width: 250,
//                       height: 100,
//                       child: TextField(
//                         decoration: const InputDecoration(
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(10)),
//                               borderSide: BorderSide(
//                                   color: Colors.blueAccent, width: 1)),
//                           hintText: "location",
//                           // labelText: IsEditable ? widget.event.location : "",
//                           floatingLabelBehavior: FloatingLabelBehavior.never,
//                           prefixIcon: Icon(
//                             Icons.location_city,
//                             color: Colors.blue,
//                           ),
//                         ),
//                         controller: taskLocation,
//                       )),
//                 ),
//
//                 //TODO: Is All Day
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                   child: SizedBox(
//                     width: 250,
//                     height: 80,
//                     child: Container(
//                       margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
//                       decoration: BoxDecoration(
//                         border:
//                             Border.all(color: Colors.blueAccent, width: 1.0),
//                         borderRadius: const BorderRadius.all(Radius.circular(
//                                 10.0) //                 <--- border radius here
//                             ),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           const Text(
//                             "Is All Day : ",
//                             style: TextStyle(color: Colors.blue),
//                           ),
//                           Checkbox(
//                             checkColor: Colors.blue,
//                             activeColor: Colors.white,
//                             value: taskIsAllDay,
//                             onChanged: (value) {
//                               setState(() {
//                                 taskIsAllDay
//                                     ? taskIsAllDay = false
//                                     : taskIsAllDay = true;
//                               });
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 //TODO: Add time and Date
//                 Container(
//                   width: double.infinity,
//                   // color: Colors.red,
//
//                   // padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
//                   margin: const EdgeInsets.fromLTRB(10, 30, 10, 10),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.blueAccent),
//                     borderRadius: const BorderRadius.all(Radius.circular(10)),
//                     // color: Colors.blue.shade200
//                   ),
//                   child:
//
//                   Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//
//                         Container(
//                           // alignment: Alignment.topLeft,
//                           child: SizedBox(
//                             width: 200,
//                             height: 150,
//                             child: TimePickerWidgetStartTime,
//                           ),
//                         ),
//                         Container(
//                           // alignment: Alignment.topRight,
//                           child: SizedBox(
//                             width: 200,
//                             height: 150,
//                             child: TimePickerWidgetEndTime,
//                           ),
//                         )
//                       ]),
//                 ),
//
//                 //TODO: priority
//                 Container(
//                   // padding: const EdgeInsets.all(10),
//                   margin: const EdgeInsets.fromLTRB(10, 30, 10, 0),
//                   // alignment: Alignment.topLeft,
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.blueAccent),
//                     borderRadius: const BorderRadius.all(Radius.circular(10)),
//                     // color: Colors.blue.shade200
//                   ),
//                   width: double.infinity,
//                   padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text("Priority: ",
//                           style: TextStyle(color: Colors.blue, fontSize: 15)),
//                       OutlinedButton(
//                         autofocus: false,
//                         onPressed: () {
//                           selectedColor = Colors.red;
//                         },
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: const [
//                             Icon(
//                               // <-- Icon
//                               Icons.circle,
//                               size: 24.0,
//                               color: Colors.red,
//                             ),
//                             SizedBox(
//                               width: 5,
//                             ),
//                             Text('High'), // <-- Text
//                           ],
//                         ),
//                       ),
//                       OutlinedButton(
//                         autofocus: false,
//                         onPressed: () {
//                           selectedColor = Colors.blue;
//                         },
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: const [
//                             Icon(
//                               // <-- Icon
//                               Icons.circle,
//                               size: 24.0,
//                               color: Colors.blue,
//                             ),
//                             SizedBox(
//                               width: 5,
//                             ),
//                             Text('Normal'), // <-- Text
//                           ],
//                         ),
//                       ),
//                       OutlinedButton(
//                         autofocus: false,
//                         onPressed: () {
//                           selectedColor = Colors.yellow;
//                         },
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: const [
//                             Icon(
//                               // <-- Icon
//                               Icons.circle,
//                               size: 24.0,
//                               color: Colors.yellow,
//                             ),
//                             SizedBox(
//                               width: 5,
//                             ),
//                             Text('Low'), // <-- Text
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             event = CleanCalendarEvent(taskSummary.text,
//                 startTime: DateTime(
//                     selectedDay.year,
//                     selectedDay.month,
//                     selectedDay.day,
//                     int.parse(TimePickerWidgetStartTime.hourSelected.text),
//                     int.parse(TimePickerWidgetStartTime.minSelected.text)),
//                 endTime: DateTime(
//                     selectedDay.year,
//                     selectedDay.month,
//                     selectedDay.day,
//                     int.parse(TimePickerWidgetEndTime.hourSelected.text),
//                     int.parse(TimePickerWidgetEndTime.minSelected.text)));
//
//             event.description = taskDesc.text;
//
//             event.location = taskLocation.text;
//             event.isAllDay = taskIsAllDay;
//             event.color = selectedColor;
//
//             if (MyHomePage.events.containsKey(DateTime(
//                 selectedDay.year, selectedDay.month, selectedDay.day))) {
//               MyHomePage.events.update(
//                   DateTime(
//                       selectedDay.year, selectedDay.month, selectedDay.day),
//                   (value) => value + [event]);
//             } else {
//               Map<DateTime, List<CleanCalendarEvent>> instance = {
//                 DateTime(selectedDay.year, selectedDay.month, selectedDay.day):
//                     [
//                   event,
//                 ]
//               };
//
//               MyHomePage.events.addAll(instance);
//             }
//             widget.notifyParent();
//
//             Navigator.pop(context);
//           },
//           tooltip: 'Increment',
//           child: const Icon(Icons.check),
//         ));
//   }
// }
