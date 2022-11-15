import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../Model/toDoModel.dart';
import 'package:intl/intl.dart';

import '../../Services/Provider/todo_provider.dart';
import '../HomePage/home_page.dart';

class ToDo_List extends StatefulWidget {
  ToDo_List({Key? key}) : super(key: key);

  @override
  State<ToDo_List> createState() => _ToDo_ListState();
}

class _ToDo_ListState extends State<ToDo_List> {

  DateTime selectedDay = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 00, 0);

  DateTime _focusedDay = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 00, 0);

  var newTaskController = TextEditingController();
  var _selectedIndex = 0 ;

  _ToDo_ListState();

  @override
  void initState()  {

      Provider.of<TodoProvider>(context ,listen:  false).getAllToDoList();
      super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(builder:
    (context , provider , child) {
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
              SizedBox(
                height: 150,
                child: TableCalendar(
                  shouldFillViewport: true,
                  calendarFormat: CalendarFormat.week,
                  firstDay: DateTime(2020),
                  lastDay: DateTime(2025),
                  focusedDay: _focusedDay,
                  currentDay: _focusedDay,
                  onDaySelected: (date, focusedDay) {
                    setState(() {
                      selectedDay = date;
                      // _handleData(selectedDay.toUtc());
                      _focusedDay = date; // update `_focusedDay` here as well
                    });
                  },
                ),
              ),

              Expanded(
                child:  provider.todoList[selectedDay]?.isNotEmpty ?? false
                    ? ListView.builder(
                        padding: const EdgeInsets.all(0.0),
                        itemBuilder: (BuildContext context, int index) {

                          // final ToDo toDoItem = selectedList[index];
                          final ToDo toDoItem = provider.todoList[selectedDay]![index];
                          final String start = DateFormat('HH:mm:aa')
                              .format(toDoItem.startTime)
                              .toString();
                          final String end = DateFormat('HH:mm:a')
                              .format(toDoItem.endTime)
                              .toString();
                          return GestureDetector(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //\t \t \t  ${index + 1}  \t \t \t
                                Text(
                                  "    ${toDoItem.title}   ",
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
                                        // _handleData(selectedDay);
                                      });

                                      // toDoItem.isDone ?
                                      //
                                      // AwesomeDialog(
                                      //     context: context,
                                      //     animType: AnimType.scale,
                                      //     dialogType: DialogType.success,
                                      //     body: const Center(child: Text(
                                      //     'You Successfully Finished your task ',
                                      //     style: TextStyle(fontStyle: FontStyle.italic , fontSize:  20),
                                      // ),),
                                      // title: 'Keep Going',
                                      // dismissOnTouchOutside: true,
                                      // btnOkOnPress: () {
                                      //
                                      // },
                                      // ).show() : null ;
                                      provider.taskIsCompleted(toDoItem);
                                    })
                              ],
                            ),

                            // onTap: _showDeleteAlert(toDoItem),
                          );
                        },
                        itemCount: provider.todoList[selectedDay]?.length ?? 0 ,
                      )
                    : const Center(
                        child: Text("no data for today ")// Image.network("https://ouch-cdn2.icons8.com/BbYaGQcG9qxVp4LAoSXm-fhbsTutCLjWaV2ESMk6GMI/rs:fit:256:171/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvMy82/YTk5NTJiMi1mNWVh/LTRkNDAtYjZlMi1h/ZGQzODUwYTIwMjUu/c3Zn.png"),
                      ),
              ),
            ]),
          ),


          bottomNavigationBar : CurvedNavigationBar(
            index: 2,
            backgroundColor: Colors.blueAccent,
            items:const <Widget>  [
              Icon(Icons.home, size: 30),
              Icon(Icons.add, size: 30),
              Icon(Icons.list_alt, size: 30),
            ],
            onTap: _onItemTapped,
          ),
        );
      }
    );
  }

  void _onItemTapped(int value) {
    setState((){
      _selectedIndex = value;
    });


    switch(_selectedIndex){
      case 0 :
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const MyHomePage()));
        break;

      case 1 :
        AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.info,
          body: Center(
              child:  Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    controller: newTaskController,
                    decoration: const InputDecoration(
                        hintText: "What do you want to do!"
                    ),
                    style: const TextStyle(fontStyle: FontStyle.italic)),
              )),
          title: 'Add New Task',
          // desc: 'This is also Ignored',
          btnOkColor : Colors.blue,

          btnOkOnPress: () {
            if (newTaskController.text.isNotEmpty ){

            Provider.of<TodoProvider>(context , listen:  false).insertTask(ToDo(
                UniqueKey().hashCode,
                title: newTaskController.text,
                startTime: selectedDay,
                endTime: selectedDay
            )) ;
            // _handleData(selectedDay);
            Provider.of<TodoProvider>(context , listen:  false).getAllToDoList();
            newTaskController.clear();
            }
            else{
              showError();
            }
          },
        ).show();
        break;
      case 2 :
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => ToDo_List()));
        break;

    }

  }

  void showError() {
    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.error,
      body: Center(
          child:  Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                controller: newTaskController,
                decoration: const InputDecoration(
                    hintText: "Task is empty"
                ),
                style: const TextStyle(fontStyle: FontStyle.italic)),
          )),
      // title: 'Add New Task',
      // desc: 'This is also Ignored',
      btnOkColor : Colors.blue,

      btnOkOnPress: () {

      },
    ).show();
  }

   _showDeleteAlert(ToDo task) {
    AwesomeDialog(
    context: context,
    animType: AnimType.scale,
    dialogType: DialogType.info,
    body: const Center(
        child:  Padding(
          padding:  EdgeInsets.all(8.0),
          child: Text(
                "Are sure to delete the Task?",
              style:  TextStyle(fontStyle: FontStyle.italic)),
        )),
    // desc: 'This is also Ignored',
    btnOkColor : Colors.blue,
    showCloseIcon : true,

    btnOkOnPress: () {
        Provider.of<TodoProvider>(context , listen: false).deleteTask(task);
    },
  ).show();
  }
}
