import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/clean_calendar_event.dart';

class TaskDetails extends StatefulWidget {
  final CleanCalendarEvent event;

  TaskDetails({Key? key, required this.event}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  var taskDesc = TextEditingController();
  var taskSummary = TextEditingController();
  var taskIsDone = TextEditingController();
  var taskStartTime = TextEditingController();
  var taskEndTime = TextEditingController();
  var taskIsAllDay = TextEditingController();
  var taskLocation = TextEditingController();
  var IsEditable = false ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.event.summary} task"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [ IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
              setState(() {
                IsEditable ?  IsEditable = false :  IsEditable = true;
              });
            },
        ),
        ],

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
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(width: 2)),
                      hintText: widget.event.description,
                      prefixIcon: const Icon(
                        Icons.description,
                        color: Colors.blue,
                      ),
                    ),
                    controller: taskDesc,
                    enabled: IsEditable,
                  )),
              SizedBox(
                  width: 250,
                  height: 100,
                  child: TextField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(width: 2)),
                      hintText: widget.event.summary,
                      // labelText: IsEditable ? widget.event.summary : "",

                      // floatingLabelBehavior: FloatingLabelBehavior.never,
                      prefixIcon: const Icon(
                        Icons.description,
                        color: Colors.blue,
                      ),
                    ),
                    controller: taskSummary,
                    enabled: IsEditable,
                  )),
              SizedBox(
                  width: 250,
                  height: 100,
                  child: TextField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(width: 2)
                      ),
                     hintText: widget.event.location,
                      // labelText: IsEditable ? widget.event.location : "",
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      prefixIcon: const Icon(
                        Icons.location_city,
                        color: Colors.blue,
                      ),
                    ),
                    controller: taskLocation,
                    enabled: IsEditable,
                  )) ,

              //TODO: Edit  time
              SizedBox(
                  width: 250,
                  height: 100,
                  child: Row(
                    children: [

                    ],
                  )

              ),
              SizedBox(
                width: 250,
                height: 80,
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                  decoration:BoxDecoration(
                    border: Border.all(
                      color:  const Color(0xABB8B7B7),
                        width: 1.0
                    ),
                    borderRadius: const BorderRadius.all(
                        Radius.circular(10.0) //                 <--- border radius here
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,

                    children: [
                      const Text(
                        "Is Done : ",
                        style: TextStyle(color: Colors.blue),
                      ),
                      Checkbox(
                        checkColor: Colors.greenAccent,
                        activeColor: Colors.white,
                        value: widget.event.isDone,
                        onChanged: (value) {
                          setState(() {
                            widget.event.isDone
                                ? widget.event.isDone = false
                                : widget.event.isDone = true;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ) ,
              SizedBox(
                width: 250,
                height: 80,
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 15),

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
                        value: widget.event.isAllDay,
                        onChanged: (value) {
                          setState(() {
                            widget.event.isAllDay
                                ? widget.event.isAllDay = false
                                : widget.event.isAllDay = true;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pop(context);
              print(taskDesc.text);

            },
            child: const Icon(Icons.check),
    )
    );
  }
}
