import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/Services/Provider/todo_provider.dart';
import 'package:todo_list/UI/Create_Event/CreateEvent_View/Creating_Event.dart';
import 'package:todo_list/UI/Event_Details/Event_Details_Display.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:badges/badges.dart';
import 'package:todo_list/Services/Provider/MyProvider.dart';
import 'package:todo_list/UI/ToDo_List/ToDo_List.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}




class _MyHomePageState extends State<MyHomePage> {
  DateTime selectedDay = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 00, 0);

  List<CleanCalendarEvent> selectedEvent = [];
  Map<DateTime, List<CleanCalendarEvent>> events =
      <DateTime, List<CleanCalendarEvent>>{};


  var _selectedIndex = 0 ;
  _MyHomePageState();

  void _handleData(date) {
    events = Provider
        .of<MyProvider>(context, listen: false)
        .events;

    setState(() {
      selectedDay = date;
      selectedEvent = events[selectedDay] ?? [];
      print(selectedEvent);
      /// sort the events based on IsDone
      /// where the done events will be in the bottom and the un done events will be the top
      selectedEvent.sort((a, b) {
        if (b.isDone) {
          return -1;
        }
        return 1;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      print("future");
      print(Provider.of<MyProvider>(context ,  listen : false ).events);
      if  ( Provider.of<MyProvider>(context ,  listen : false ).events.isEmpty  ) {
        Provider.of<MyProvider>(context, listen: false).getAllEvents();
        events = Provider
            .of<MyProvider>(context, listen: false)
            .events;
      }
      else {


        events = Provider
            .of<MyProvider>(context, listen: false)
            .events;
      }

    });

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }

  refresh() {

    Provider.of<MyProvider>(context, listen: false).getAllEvents();

    setState(() {



      events = Provider
          .of<MyProvider>(context, listen: false)
          .events;

      _handleData(selectedDay);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<MyProvider>(builder: (context, provider, child) {

      return Scaffold(
        appBar: AppBar(
          title: Text("Events"),
          backgroundColor: Colors.blueAccent,
        ),

        body: SafeArea(
          child: Container(
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
            child: Flexible(
              child: Calendar(
                startOnMonday: true,
                selectedColor: Colors.blue,
                todayColor: Colors.red,
                eventColor: Colors.blue,
                eventDoneColor: Colors.green,
                bottomBarColor: Colors.deepOrange,
                initialDate: DateTime.now(),
                onDateSelected: (date) {
                  print(date);

                  selectedDay = date;
                  // return _handleData(date);
                },
                events: events,
                onEventSelected: (event) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Event_Details_Display(
                                event: event,)));
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
                weekDays: const [
                  'Sat',
                  'Sun',
                  'Mon',
                  'Tue',
                  'Wed',
                  'Thu',
                  'Fri'
                ],

                // locale: "ar",
              ),
            ),
          ),
        ),



        drawer: SizedBox(
          width: 250,
          child: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Image.asset('assets/images/sketchbook.png'),
                ),
                ListTile(
                  title: const Text('schedule'),
                  leading: const Icon(
                    Icons.schedule,
                    color: Colors.blueAccent,
                  ),
                  trailing: Badge(
                    badgeContent:
                       Text("${ MyProvider.eventsCountToday ?? 0 }")
                        ,
                    child: null,
                  ),
                  onTap: () {
                    Navigator.pop(context);

                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => MyHomePage(title: "Events")));
                  },
                ),
                ListTile(
                  title: const Text("Creating Event"),
                  leading: const Icon(
                    Icons.add,
                    color: Colors.blueAccent,
                  ),
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Creating_Event(
                                  selectedDay: selectedDay,
                                  // notifyParent: refresh,
                                )));
                  },
                ),
                // ListTile(
                //   title: const Text('Habits'),
                //   leading: const Icon(
                //     Icons.heat_pump,
                //     color: Colors.blueAccent,
                //   ),
                //   onTap: () {
                //     Navigator.pop(context);
                //     //
                //     // Navigator.push(context,
                //     //     MaterialPageRoute(
                //     //         builder: (context) =>
                //     //             MyHomePage(title: "Events")));
                //   },
                // ),
                ListTile(
                  title: const Text('Todo List'),
                  leading: const Icon(
                    Icons.list,
                    color: Colors.blueAccent,
                  ),
                  trailing: Badge(
                      badgeContent:
                      Text("${ TodoProvider.todoCountToday ?? 0 }")),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ToDo_List()));
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar : CurvedNavigationBar(
          backgroundColor: Colors.blueAccent,
          index: 0,
          items:const <Widget>  [

            Icon(Icons.home, size: 30),
            Icon(Icons.add, size: 30),
            Icon(Icons.list_alt, size: 30),
          ],
          onTap: _onItemTapped,
        ),


      );
    });
  }

  void _onItemTapped(int value) {
    setState((){
      _selectedIndex = value;
    });


    switch(_selectedIndex){
      case 0 :
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => const MyHomePage()));
        break;

      case 1 :
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Creating_Event(selectedDay: selectedDay)));
        break;
      case 2 :
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ToDo_List()));
        break;

    }

  }
}
