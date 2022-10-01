// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:todo_list/Services/Provider/MyProvider.dart';
import 'package:todo_list/UI/Event_Details/Event_details_screen.dart';
// import 'package:todo_list/AddingTask/AddingNewTask.dart';
import 'Services/DataBase/DB_Helper.dart';
import 'Services/Notification_Api.dart';
import 'UI/HomePage/home_page.dart';
import 'package:provider/provider.dart';
//If you just want the latest
import 'package:timezone/data/latest.dart' as tz;

//If you use the 10y db variant
// import 'package:timezone/data/latest_10y.dart' as tz;

//If you want to import all the db variants
// import 'package:timezone/data/latest_all.dart' as tz;
Map<int, Color> color = {
  50: Color.fromRGBO(255, 92, 87, .1),
  100: Color.fromRGBO(255, 92, 87, .2),
  200: Color.fromRGBO(255, 92, 87, .3),
  300: Color.fromRGBO(255, 92, 87, .4),
  400: Color.fromRGBO(255, 92, 87, .5),
  500: Color.fromRGBO(255, 92, 87, .6),
  600: Color.fromRGBO(255, 92, 87, .7),
  700: Color.fromRGBO(255, 92, 87, .8),
  800: Color.fromRGBO(255, 92, 87, .9),
  900: Color.fromRGBO(255, 92, 87, 1),
};

MaterialColor colorCustom = MaterialColor(0xFFFF5C57, color);

void main() async {
  tz.initializeTimeZones();
  WidgetsFlutterBinding.ensureInitialized(); /// -> You only need to call this method if you need the binding to be initialized before calling runApp
  await DBHelper.initDB();

  runApp(
      ChangeNotifierProvider(
        create: (context) => MyProvider(),
        child:  const MyApp(),
      ),
  );

      // const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
     /* ChangeNotifierProvider<MyProvider>(
      create: (context) => MyProvider(),
      builder: (buildContext, child) {
      return*/ MyHomePage(title: "Events")

      // })


    );
    }
  }

