import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../Model/toDoModel.dart';
import 'package:intl/intl.dart';

class ToDo_List extends StatefulWidget {
  ToDo_List({Key? key}) : super(key: key);
  Map<DateTime, List<ToDo>> ToDoList = {
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 02,
            0)
        .toUtc(): [
      ToDo(
          title: "Take Assement",
          startTime: DateTime.now(),
          endTime: DateTime.now(),
          isDone: false),
      ToDo(
          title: "Take Assement",
          startTime: DateTime.now(),
          endTime: DateTime.now(),
          isDone: false),
      ToDo(
          title: "Take Assement",
          startTime: DateTime.now(),
          endTime: DateTime.now(),
          isDone: true)
    ],
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1,
            02, 0)
        .toUtc(): [
      ToDo(
          title: "Take Assement",
          startTime: DateTime.now(),
          endTime: DateTime.now(),
          isDone: true),
      ToDo(
          title: "Take Assement",
          startTime: DateTime.now(),
          endTime: DateTime.now(),
          isDone: false),
      ToDo(
          title: "Take Assement",
          startTime: DateTime.now(),
          endTime: DateTime.now(),
          isDone: true)
    ]
  };

  @override
  State<ToDo_List> createState() => _ToDo_ListState(ToDoList);
}

class _ToDo_ListState extends State<ToDo_List> {
  DateTime selectedDay = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 02, 0);

  DateTime _focusedDay = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 02, 0);

  var newTask = TextEditingController();
  late List<ToDo> selectedList;
  Map<DateTime, List<ToDo>> ToDo_List;

  _ToDo_ListState(this.ToDo_List);

  void _handleData(date) {

    setState(() {
      selectedDay = date;
      selectedList = ToDo_List[selectedDay] ?? [];

      /// sort the events based on IsDone
      /// where the done events will be in the bottom and the un done events will be the top
      selectedList.sort((a, b) {
        if (b.isDone) {
          return -1;
        }
        return 1;
      });
    });
  }

  @override
  void initState() {

    _handleData(selectedDay.toUtc());
    // selectedList = ToDo_List[selectedDay] ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Todo List"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
              Colors.blueAccent.withOpacity(0.1),
              Colors.white,
            ],
                stops: const [
              0.0,
              1.0
            ])
            // color: Colors.blue.shade200
            ),
        child: Column(children: [
          Container(
            margin: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "My Todo List      ",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                RotationTransition(
                  turns: const AlwaysStoppedAnimation(15 / 360),
                  child: Image.network(
                    "https://ouch-cdn2.icons8.com/BbYaGQcG9qxVp4LAoSXm-fhbsTutCLjWaV2ESMk6GMI/rs:fit:256:171/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvMy82/YTk5NTJiMi1mNWVh/LTRkNDAtYjZlMi1h/ZGQzODUwYTIwMjUu/c3Zn.png",
                    height: 70,
                    width: 90,
                  ),
                ),
              ],
            ),
          ),
          //       Container(
          //         height: 100,
          //         child: CalendarDatePicker(
          //
          //         initialDate: DateTime.now(),
          //         firstDate: DateTime(2020, 1, 1),
          //         lastDate: DateTime(2025, 12, 30),
          //         onDateChanged: (DateTime value) {
          //           print(value);
          //           _handleData(value);
          //         },
          //
          // ),
          //       ),
          SizedBox(
            height: 150,
            child: TableCalendar(
              shouldFillViewport: true,
              calendarFormat: CalendarFormat.week,
              firstDay: DateTime(2020),
              lastDay: DateTime(2025),
              focusedDay: _focusedDay,
              currentDay: _focusedDay,
              onDaySelected: (selected_Day, focusedDay) {
                setState(() {
                  selectedDay = selected_Day;

                  _handleData(selectedDay.toUtc());
                  _focusedDay =
                      selected_Day; // update `_focusedDay` here as well
                });
              },
            ),
          ),

          Expanded(
            child: selectedList.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.all(0.0),
                    itemBuilder: (BuildContext context, int index) {
                      final ToDo toDoItem = selectedList[index];
                      final String start = DateFormat('HH:mm:aa')
                          .format(toDoItem.startTime)
                          .toString();
                      final String end = DateFormat('HH:mm:a')
                          .format(toDoItem.endTime)
                          .toString();

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Text(
                            "\t \t \t  ${index + 1}  \t \t \t ${toDoItem.title}",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.normal),
                          ),
                          Checkbox(
                              checkColor: Colors.blue,
                              activeColor: Colors.white,
                              value: toDoItem.isDone,
                              onChanged: (value) {
                                setState(() {
                                  toDoItem.isDone
                                      ? toDoItem.isDone = false
                                      : toDoItem.isDone = true;

                                  _handleData(selectedDay);
                                });

                                toDoItem.isDone ?  AwesomeDialog(
                                    context: context,
                                    animType: AnimType.scale,
                                    dialogType: DialogType.success,
                                    body: const Center(child: Text(
                                    'You Successfully Finished your task ',
                                    style: TextStyle(fontStyle: FontStyle.italic , fontSize:  20),
                                ),),
                                title: 'Keep Going',
                                btnOkOnPress: () {
                                },
                                ).show() : null ;
                              })
                        ],
                      );
                    },
                    itemCount: selectedList.length,
                  )
                : Center(
                    child: Image.network("https://ouch-cdn2.icons8.com/BbYaGQcG9qxVp4LAoSXm-fhbsTutCLjWaV2ESMk6GMI/rs:fit:256:171/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvMy82/YTk5NTJiMi1mNWVh/LTRkNDAtYjZlMi1h/ZGQzODUwYTIwMjUu/c3Zn.png"),
                  ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.info,
            body: Center(
                child:  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                      controller: newTask,
                      decoration: const InputDecoration(
                        hintText: "What do you want to do!"
                      ),
                      style: const TextStyle(fontStyle: FontStyle.italic)),
                )),
            title: 'Add New Task',
            // desc: 'This is also Ignored',
            btnOkColor : Colors.blue,
            btnOkOnPress: () {
              ToDo_List[selectedDay]?.add( ToDo(
                  title: newTask.text,
                  startTime: selectedDay,
                  endTime: selectedDay
              ));
              _handleData(selectedDay);
              newTask.clear();
            },
          ).show();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
