
import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/clean_calendar_event.dart';
import 'package:todo_list/Model/toDoModel.dart';

import '../DataBase/Events_DB_Operations.dart';
import '../DataBase/ToDo_DB_Operations.dart';

//todo Step 1 in Provider

class MyProvider with ChangeNotifier {

  // static MyProvider? instance ;
  Map<DateTime, List<CleanCalendarEvent>> events =
      <DateTime, List<CleanCalendarEvent>> {
  };

  static int? eventsCountToday;




  MyProvider();
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
    notifyListeners();

  }






}
