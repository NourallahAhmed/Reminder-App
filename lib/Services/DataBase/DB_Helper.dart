import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';


class DBHelper {

  /// singletone pattern
  static Database? _db;

  static const int _versionEvents = 5;
  static const int _versionTodo = 1;

  static const String _tableNameEvents = "eventsDB";
  static const String _tableNameTodo = "todoDB";

  static Future<void> initDB() async {
    if(_db != null){
      debugPrint("not null db");
      return;
    }

    try{
      // getDatabasesPath
      String _pathEventsDB = await getDatabasesPath() + _tableNameEvents;
      // String _pathEventsTodo = await getDatabasesPath() + _tableNameTodo;
      debugPrint("in DataBase Path");


      //openDataBase
      _db = await openDatabase(
          _pathEventsDB  ,
          version:  _versionEvents ,
          onCreate: ( Database db, int version) async {
            await db.execute(
          '''CREATE TABLE $_tableNameEvents(
                  id INTEGER PRIMARY KEY AUTOINCREMENT, 
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
    }
    catch(e){
      print("error $e");
    }

  }



  static Future<int> insertEvent(CleanCalendarEvent event) async{
        print("insert");
        final insert = await _db!.insert(_tableNameEvents ,  event.toJson());
        print(await DBHelper.getEvents());
        return insert;
  }


  static Future<int> deleteEvent(CleanCalendarEvent event) async{
        print("insert");
       return await _db!.delete(_tableNameEvents, where: "id = ?" ,whereArgs: [event.id]);
  }


  static Future<int> updateEventCompletion(CleanCalendarEvent event) async{
        print("insert");
       return await _db!.rawUpdate(''' 
       UPDATE $_tableNameEvents
       SET isDone = ?
       WHERE id = ?       
       ''', [ event.isDone? 1 : 0,event.id]);
  }


  static Future<int> updateEvent(CleanCalendarEvent event) async{
        print("insert");
       return await _db!.rawUpdate(''' 
       
       UPDATE $_tableNameEvents
       SET isDone = ?
       SET summery = ?
       SET description = ?
       SET location = ?
       SET startTime = ?
       SET endTime = ?
       SET isAllDay = ?
       WHERE id = ?    
          
       ''', [
         event.isDone? 1 : 0,
         event.summary,
         event.description,
         event.location,
         event.startTime,
         event.endTime,
         event.isAllDay? 1: 0,
         event.id]);
  }


  // static Future<List<CleanCalendarEvent>> getEvents() async{
  //   print("guery");
  //   final List<Map<String, dynamic>> events = await _db!.query(_tableNameEvents);
  //   return List.generate( events.length, (i) {
  //     return CleanCalendarEvent(events[i]['summary'],
  //         startTime: DateTime.parse( events[i]['startTime']),
  //         endTime:  DateTime.parse(events[i]['endTime']),
  //         description: events[i]['description'],
  //         color: Color(int.parse(events[i]['color'])),
  //         location:  events[i]['location'],
  //         isAllDay:  events[i]['isAllDay'] == 0 ? false : true,
  //         isDone:  events[i]['isDone'] == 0 ? false : true,
  //     );
  //   });
  // }




  static Future<List<CleanCalendarEvent>> getEvents() async{
    print("guery");
    final List<Map<String, dynamic>> events = await _db!.query(_tableNameEvents);
    var eventList =  List.generate( events.length, (i) {
      return CleanCalendarEvent(events[i]['summary'],
        startTime: DateTime.parse( events[i]['startTime']),
        endTime:  DateTime.parse(events[i]['endTime']),
        description: events[i]['description'],
        color: Color(int.parse(events[i]['color'])),
        location:  events[i]['location']  ,
        isAllDay:  events[i]['isAllDay'] == 0 ? false : true,
        isDone:  events[i]['isDone'] == 0 ? false : true,
      );
    });
    //

    return eventList ;
  }
}