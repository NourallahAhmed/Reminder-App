import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import '../../Model/toDoModel.dart';


class DBHelper {

  /// singletone pattern
  static Database? _db;
  static Database? _db_ToDO;

  static const int _versionEvents = 6;
  static const int _versionTodo = 2;

  static const String _tableNameEvents = "eventsDB";
  static const String _tableNameTodo = "todoDB";

  static Future<void> initDB() async {
    if(_db != null){
      debugPrint("not null db");
      return;
    }

    try{
      // getDatabasesPath
      //todo : eventsDB
      String _pathEventsDB = await getDatabasesPath() + _tableNameEvents;

      //todo :  todoListDB
      String _pathTodoDB = await getDatabasesPath() + _tableNameTodo;

      debugPrint("in DataBase Path");


      //openDataBase eventsDB
      _db = await openDatabase(
          _pathEventsDB  ,
          version:  _versionEvents ,
          onCreate: ( Database db, int version) async {

            ///*AUTOINCREMENT*/
            await db.execute(
          '''CREATE TABLE $_tableNameEvents(
                  id INTEGER PRIMARY KEY , 
                  summary TEXT, 
                  description TEXT,
                  location TEXT, 
                  startTime TEXT,
                  endTime TEXT,
                  color TEXT,
                  isAllDay INTEGER,
                  isDone INTEGER
                  )''',
        ).catchError((error) => print(error.toString()));;
          });


      //openDataBase ToDoDB
      _db_ToDO = await openDatabase(
          _pathTodoDB  ,
          version:  _versionTodo ,
          onCreate: ( Database db, int version) async {

            ///*AUTOINCREMENT*/
            await db.execute(
          '''CREATE TABLE $_tableNameTodo(
                  id INTEGER PRIMARY KEY , 
                  title TEXT, 
                  description TEXT,
                  startTime TEXT,
                  endTime TEXT,
                  isDone INTEGER
                  )''',
        ).catchError((error) => print(error.toString()));;
          });
    }
    catch(e){
      print("error $e");
    }

  }


  static Database? getTodoDBInstance() => _db_ToDO;
  static String? getTodoName() => _tableNameTodo;

  static Database? getEventsDBInsteance() => _db;
  static String? getEventsName() => _tableNameEvents;








}