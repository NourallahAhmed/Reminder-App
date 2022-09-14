import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:todo_list/CustomTimePickerWidget/TimePickerWidget.dart';

class AddingNewTask extends StatefulWidget {
  final DateTime selectedDay;

  const AddingNewTask({Key? key, required this.selectedDay}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddingNewTaskState();
}

class _AddingNewTaskState extends State<AddingNewTask> {
  var taskDesc = TextEditingController();
  var taskSummary = TextEditingController();
  var taskIsDone = TextEditingController();
  var taskStartTime = TextEditingController();
  var taskEndTime = TextEditingController();
  var taskIsAllDay = TextEditingController();
  var taskLocation = TextEditingController();

  late final CleanCalendarEvent event;


  //MARK: TimePicker
  var TimePickerWidgetInstance = TimePickerWidget();



  //
  // void _selectTime() async {
  //   final TimeOfDay? newTime = await showTimePicker(
  //     context: context,
  //     initialTime: _time,
  //   );
  //   if (newTime != null) {
  //     setState(() {
  //       _time = newTime;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Create new task"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          // color: widget.event.color,
          height: double.infinity,
          // width: double.infinity,

          padding: const EdgeInsets.all(50.0),
          // margin: const EdgeInsets.all(10.0) ,
          child: SingleChildScrollView(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    width: 250,
                    height: 100,
                    child: TextField(
                      decoration: const InputDecoration(
                        border:  OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 2)),
                        hintText: "Description",
                        prefixIcon:  Icon(
                          Icons.description,
                          color: Colors.blue,
                        ),
                      ),
                      controller: taskDesc,

                    )
                ),
                SizedBox(
                    width: 250,
                    height: 100,
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 2)),
                        hintText: "Summary",
                        // labelText: IsEditable ? widget.event.summary : "",

                        // floatingLabelBehavior: FloatingLabelBehavior.never,
                        prefixIcon: Icon(
                          Icons.description,
                          color: Colors.blue,
                        ),
                      ),
                      controller: taskSummary,

                    )),
                SizedBox(
                    width: 250,
                    height: 100,
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 2)
                        ),
                        hintText: "location",
                        // labelText: IsEditable ? widget.event.location : "",
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        prefixIcon: Icon(
                          Icons.location_city,
                          color: Colors.blue,
                        ),
                      ),
                      controller: taskLocation,
                    )
                ) ,

                // SizedBox(
                //     width: 50,
                //     height: 100,
                //     child: Row(
                //       children: [
                //          TextField(
                //           decoration: const InputDecoration(
                //
                //             border: OutlineInputBorder(
                //                 borderRadius: BorderRadius.all(Radius.circular(10)),
                //                 borderSide: BorderSide(width: 2)
                //             ),
                //             hintText: "location",
                //             // labelText: IsEditable ? widget.event.location : "",
                //             floatingLabelBehavior: FloatingLabelBehavior.never,
                //             prefixIcon: Icon(
                //               Icons.location_city,
                //               color: Colors.blue,
                //             ),
                //           ),
                //           controller: taskLocation,
                //         ),
                //       ],
                //     )
                // ) ,

                SizedBox(
                  width: 250,
                  height: 80,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),

                    decoration:BoxDecoration(
                      border: Border.all(
                          color:  const Color(0xABB8B7B7),
                          width: 1.0
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(
                          10.0) //                 <--- border radius here
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,

                      children: [
                        const Text(
                          "Is All Day : ",
                          style: TextStyle(color: Colors.blue),
                        ),
                        Checkbox(
                          checkColor: Colors.greenAccent,
                          activeColor: Colors.white,
                          value: false ,
                          onChanged: (value) {
                            event.isAllDay = true;
                            setState(() {
                              event.isAllDay
                                  ? event.isAllDay = false
                                  : event.isAllDay = true;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),


               //TODO: Add time and Date

                SizedBox(
                  width: 100,
                  height: 200,
                  child:

                      TimePickerWidgetInstance
                  ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
           event.description = taskDesc.text ;
           event.summary = taskSummary.text ;
           event.location = taskLocation.text ;

           print();
           // event.startTime = taskStartTime.text ;
           // event.endTime = taskEndTime.text ;

          },
          tooltip: 'Increment',
          child: const Icon(Icons.check),
        )

    );
  }
}
