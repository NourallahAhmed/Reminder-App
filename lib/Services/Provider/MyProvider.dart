import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/clean_calendar_event.dart';
import 'package:todo_list/Services/DataBase/DB_Helper.dart';

//todo Step 1 in Provider

class MyProvider with ChangeNotifier {

  // static MyProvider? instance ;
  Map<DateTime, List<CleanCalendarEvent>> events =
      <DateTime, List<CleanCalendarEvent>> {
    // DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day): [
    //   CleanCalendarEvent('Event A',
    //       startTime: DateTime(DateTime.now().year, DateTime.now().month,
    //           DateTime.now().day, 10, 0),
    //       endTime: DateTime(DateTime.now().year, DateTime.now().month,
    //           DateTime.now().day, 12, 0),
    //       description: 'A special event',
    //       color: Colors.blue,
    //       isDone: true),
    // ]
  };




  MyProvider(){
    getAllEvents();
  }

  //todo: func to get all events
  Future<Map<DateTime, List<CleanCalendarEvent>>> getAllEvents() async {

    events.clear();
    final allEvents = await DBHelper.getEvents();

    if (allEvents.isNotEmpty) {
      convertToMap(allEvents);
      notifyListeners();
    }

    return events;
  }

  //todo: func convert to map DateTime:[CleanCalenderEvent]
  void convertToMap(List<CleanCalendarEvent> allevents) {
    for (var event in allevents) {
      handleEvent(event);

      notifyListeners();
    }
  }


  void handleEvent(CleanCalendarEvent event) {

    print(DateTime(
        event.startTime.year, event.startTime.month, event.startTime.day));

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
  }



  // todo:  InsertEvent

  void insertEvent(CleanCalendarEvent event){


    DBHelper.insertEvent(event);

    // handleEvent(event);

    notifyListeners();

  }

  //todo : deleteEvent
  void deleteEvent(CleanCalendarEvent event){
    //remove form database
    DBHelper.deleteEvent(event);


    //remove from local list
    // events.remove(event);


    // notify the providers
    notifyListeners();

  }

  //todo : updateEvent

  void editEvent(CleanCalendarEvent event){
    // edit the database
    DBHelper.updateEvent(event);

    
    
    

    //edit the local List
    events.removeWhere((key, value) => value.map((e) => e.id) == event.id);   //remove the previous one

    handleEvent(event);  //adding the new version


    //notify
    notifyListeners();
  }

  //todo : EventIsDone

  void eventIsCompleted(CleanCalendarEvent event){
    //update DB
    DBHelper.updateEventCompletion(event);


    // events.removeWhere((key, value) => value.map((e) => e.id) == event.id);   //remove the previous one

    // handleEvent(event);

    notifyListeners();

  }




}
