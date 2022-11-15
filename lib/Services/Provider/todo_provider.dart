import 'package:flutter/material.dart';

import '../../Model/toDoModel.dart';
import '../DataBase/ToDo_DB_Operations.dart';

class TodoProvider with ChangeNotifier {
  Map<DateTime, List<ToDo>> todoList =
  <DateTime, List<ToDo>> {
  };

  static int? todoCountToday;


  bool _isloaded = false;

  bool get isLoaded => _isloaded;


  Future<void> getAllToDoList() async {
    _isloaded = false;
    print("get All todo List");

    todoList.clear();
    final allToDo = await ToDO_DB_Operations.getTodoList();
    if (allToDo.isNotEmpty) {
      convertToMap2(allToDo);
    }
    print("todoProvider getAllToDoList ${todoList}" );

    notifyListeners();


  }


  //todo: func convert to map DateTime:[ToDo]
  void convertToMap2(List<ToDo> todos) {

    print("convert To Map");
    for (var todo in todos) {
      handletodoList(todo);
    }
    print("outside the loop of todo list ");
    _isloaded = true;
    notifyListeners();

  }


  void handletodoList(ToDo todo) {
    print("handletodoList");


    if (todoList.containsKey(
        todo.startTime
    )) {
      todoList.update(

          todo.startTime,
              (value) => value + [todo]);
    } else {
      Map<DateTime, List<ToDo>> instance = {

        todo.startTime: [
          todo,
        ]
      };
      todoList.addAll(instance);
    }
    todoCountToday = todoList[DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)]?.length ?? 0;



    print("Provider todoList ${todoList}");
  }



  /// DB Operations


  // todo:  Inserttodo

  void insertTask(ToDo event){


    ToDO_DB_Operations.insertTask(event);
    // getAllToDoList();
    notifyListeners();

  }

  //todo : deletetodo
  void deleteTask(ToDo event){
    //remove form database
    ToDO_DB_Operations.deleteTask(event);

    getAllToDoList();



    // notify the providers
    notifyListeners();

  }



  //todo : TaskIsDone

  void taskIsCompleted(ToDo event){
    //update DB
    ToDO_DB_Operations.updateTaskCompletion(event);
    getAllToDoList();

    notifyListeners();

  }

}