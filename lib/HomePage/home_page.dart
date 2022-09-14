import 'package:flutter/material.dart';

import '../AddingTask/AddingNewTask.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';

import '../TaskDetails/task_details_screen.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  static Map<DateTime, List<CleanCalendarEvent>> events = {
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day): [
      CleanCalendarEvent('Event A',
          startTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, 10, 0),
          endTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, 12, 0),
          description: 'A special event',
          color: Colors.blue,
          isDone: true),
    ],
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2):
        [
      CleanCalendarEvent('Event B',
          startTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 10, 0),
          endTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 12, 0),
          color: Colors.orange),
      CleanCalendarEvent('Event C',
          startTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 14, 30),
          endTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 17, 0),
          color: Colors.pink),
    ],
  };

  @override
  State<MyHomePage> createState() => _MyHomePageState(MyHomePage.events);
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime selectedDay = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 10, 0);

  late List<CleanCalendarEvent> selectedEvent;
  Map<DateTime, List<CleanCalendarEvent>> events;

  _MyHomePageState(this.events);

  void _handleData(date) {
    setState(() {
      selectedDay = date;
      selectedEvent = events[selectedDay] ?? [];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    selectedEvent = events[selectedDay] ?? [];
    print("events");
    print(events);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            print("Pressed");
          },
        ),
      ),

      body: SafeArea(
        child: Container(
          color: Colors.white30,
          child: Calendar(
            startOnMonday: true,
            selectedColor: Colors.blue,
            todayColor: Colors.red,
            eventColor: Colors.blue,
            eventDoneColor: Colors.green,
            bottomBarColor: Colors.deepOrange,
            onRangeSelected: (range) {
              print('selected Day ${range.from},${range.to}');
            },
            onDateSelected: (date) {
              return _handleData(date);
            },
            events: events,
            onEventSelected: (event) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TaskDetails(
                            event: event,
                          )));
            },
            isExpanded: true,
            dayOfWeekStyle: const TextStyle(
              fontSize: 15,
              color: Colors.black12,
              fontWeight: FontWeight.w100,
            ),
            bottomBarTextStyle: const TextStyle(
              color: Colors.white,
            ),
            hideBottomBar: false,
            hideArrows: false,
            weekDays: const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(selectedDay);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AddingNewTask(selectedDay: selectedDay)));
        },
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
