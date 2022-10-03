import 'package:sqflite_common/sqlite_api.dart';
import 'package:todo_list/Services/DataBase/DB_Helper.dart';

import '../../Model/toDoModel.dart';

class ToDO_DB_Operations {

   static Database? _db_ToDo  = DBHelper.getTodoDBInstance();

   static String? _tableNameTodo =     DBHelper.getTodoName();

  // static int? _versionTodo = DBHelper.getVersion();

  ///TODO Table
  static Future<List<ToDo>> getTodoList() async{
    print("guery TODO");


    final List<Map<String, dynamic>> events = await _db_ToDo!.query(_tableNameTodo!);


    print(events);


    var toDoList =  List.generate( events.length, (i) {

      print(" from get todo List DB ${events[i]}");

      return ToDo(events[i]['id'],
        title: events[i]['title'],
        startTime: DateTime.parse( events[i]['startTime']),
        endTime:  DateTime.parse(events[i]['endTime']),
        description: events[i]['description'],
        isDone:  events[i]['isDone'] == 0 ? false : true,
      );

    });
    //
    print("after generate ${toDoList}");
    return toDoList ;
  }

  static Future<int> insertTask(ToDo todo) async{
    print("insert todo");
    final insert = await _db_ToDo!.insert(_tableNameTodo! ,  todo.toJson());

    print(insert);


    print(await ToDO_DB_Operations.getTodoList());


    return insert;
  }

  static Future<int> updateTaskCompletion(ToDo todo) async{
    print("updateTodoCompletion");


    print("${todo.id}  ${todo.description} ${todo.isDone}");
    final update = await _db_ToDo!.rawUpdate('''
           UPDATE $_tableNameTodo
           SET isDone = ?
           WHERE id = ?
           ''',  [todo.isDone? 1 : 0  , todo.id]);

    Future.delayed(Duration.zero, () async {
      print("update $update");
      final todoList = await ToDO_DB_Operations.getTodoList();
      print(todoList.map((e) => "${todo.id} ${e.description} ${e.isDone}"));

    });




    return update;
  }

  static Future<int> deleteTask(ToDo event) async{
    print("insert todo");
    return await _db_ToDo!.delete(_tableNameTodo!, where: "id = ?" ,whereArgs: [event.id]);
  }

}