import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/clean_calendar_event.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/Services/DataBase/DB_Helper.dart';

class Events_DB_Operations{

  static Database? _db = DBHelper.getEventsDBInsteance();

  static String?  _tableNameEvents = DBHelper.getEventsName();

  static Future<int> insertEvent(CleanCalendarEvent event) async{
    print("insert");
    final insert = await _db!.insert(_tableNameEvents! ,  event.toJson());
    print(await Events_DB_Operations.getEvents());
    return insert;
  }


  static Future<int> deleteEvent(CleanCalendarEvent event) async{
    print("insert");
    return await _db!.delete(_tableNameEvents!, where: "id = ?" ,whereArgs: [event.id]);
  }


  static Future<int> updateEventCompletion(CleanCalendarEvent event) async{
    print("updateEventCompletion");


    print("${event.id}  ${event.description} ${event.isDone}");
    final update = await _db!.rawUpdate('''
           UPDATE $_tableNameEvents
           SET isDone = ?
           WHERE id = ?
           ''',  [1 , event.id]);

    Future.delayed(Duration.zero, () async {
      print("update $update");
      final events = await Events_DB_Operations.getEvents();
      print(events.map((e) => "${event.id} ${e.description} ${e.isDone}"));

    });




    return update;
  }


  static Future<int> updateEvent(CleanCalendarEvent event) async{
    print("updateEvent");
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
    final List<Map<String, dynamic>> events = await _db!.query(_tableNameEvents!);
    var eventList =  List.generate( events.length, (i) {
      return CleanCalendarEvent(events[i]['id'],
        events[i]['summary'],
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