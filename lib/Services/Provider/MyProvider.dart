import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/clean_calendar_event.dart';
import 'package:todo_list/Model/toDoModel.dart';
import 'package:todo_list/Services/DataBase/DB_Helper.dart';

import '../DataBase/Events_DB_Operations.dart';
import '../DataBase/ToDo_DB_Operations.dart';

//todo Step 1 in Provider

class MyProvider with ChangeNotifier {

  // static MyProvider? instance ;
  Map<DateTime, List<CleanCalendarEvent>> events =
      <DateTime, List<CleanCalendarEvent>> {
  };
 Map<DateTime, List<ToDo>> todoList =
      <DateTime, List<ToDo>> {
  };
  static int? eventsCountToday;
  static int? todoCountToday;


  MyProvider(){
    // getAllEvents();

  }

  //todo: func to get all events
  void getAllEvents() async {

    events.clear();
    final allEvents = await Events_DB_Operations.getEvents();

    if (allEvents.isNotEmpty) {
      convertToMap(allEvents);
    }
  }

  //todo: func convert to map DateTime:[CleanCalenderEvent]
  void convertToMap(List<CleanCalendarEvent> allevents) {
    for (var event in allevents) {
      handleEvent(event);
    }
  }


  void handleEvent(CleanCalendarEvent event) {
    if (events.containsKey(DateTime(
        event.startTime.year, event.startTime.month, event.startTime.day))) {
      events.update(
          DateTime(event.startTime.year, event.startTime.month,
              event.startTime.day),
              (value) => value + [event]);
    } else {
      Map<DateTime, List<CleanCalendarEvent>> instance = {
        DateTime(event.startTime.year, event.startTime.month,
            event.startTime.day): [
          event,
        ]
      };
      events.addAll(instance);
    }
    eventsCountToday = events[DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)]?.length ?? 0;
    notifyListeners();

  }



  // todo:  InsertEvent

  void insertEvent(CleanCalendarEvent event){


    Events_DB_Operations.insertEvent(event);
    getAllEvents();


    notifyListeners();

  }

  //todo : deleteEvent
  void deleteEvent(CleanCalendarEvent event){
    //remove form database
    Events_DB_Operations.deleteEvent(event);


    //remove from local list
    // events.remove(event);

    getAllEvents();
    // notify the providers
    notifyListeners();

  }

  //todo : updateEvent

  void editEvent(CleanCalendarEvent event){
    print("editEvent");

    // edit the database
    Events_DB_Operations.updateEvent(event);

    //edit the local List
    events.removeWhere((key, value) => value.map((e) => e.id) == event.id);   //remove the previous one

    handleEvent(event);  //adding the new version

    getAllEvents();
    //notify
    notifyListeners();
  }




  //todo : EventIsDone

  void eventIsCompleted(CleanCalendarEvent event){
    //update DB
    Events_DB_Operations.updateEventCompletion(event);


    // events.removeWhere((key, value) => value.map((e) => e.id) == event.id);   //remove the previous one

    // handleEvent(event);

    notifyListeners();

  }




  //TODO:_________________________ TODO TABLE ________________________________



  //todo: func to get all TODO List



  void getAllToDoList() async {
    print("get All todo List");
    todoList.clear();
    final allToDo = await ToDO_DB_Operations.getTodoList();
    if (allToDo.isNotEmpty) {

      convertToMap2(allToDo);
      notifyListeners();
    }

  }

  //todo: func convert to map DateTime:[ToDo]
  void convertToMap2(List<ToDo> allevents) {

    print("convert To Map");
    for (var event in allevents) {
      print("loop ${event}");

      handletodoList(event);

      notifyListeners();
    }
  }


  void handletodoList(ToDo event) {
    print("handletodoList");


    if (todoList.containsKey(
      event.startTime
      )) {
      todoList.update(

              event.startTime,
              (value) => value + [event]);
    } else {
      Map<DateTime, List<ToDo>> instance = {

          event.startTime: [
          event,
        ]
      };
      todoList.addAll(instance);
    }
   todoCountToday = todoList[DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)]?.length ?? 0;

    print("Provider todoList ${todoList}");
  }



  // todo:  Inserttodo

  void insertTask(ToDo event){


    ToDO_DB_Operations.insertTask(event);
    getAllToDoList();
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
