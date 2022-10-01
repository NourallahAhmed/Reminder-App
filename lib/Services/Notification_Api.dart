



import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

import 'package:timezone/timezone.dart' as tz;
class Notification_Api {

  //plugin

  static final _notifications = FlutterLocalNotificationsPlugin();

  // ??
  static final onNotifications = BehaviorSubject<String?>();


  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        channelDescription:
        'channel description',
        importance: Importance.max,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }


  //click on notifiction to show the event details

  static Future init({bool initScheduled = false}) async{
    final android = AndroidInitializationSettings("@mipmap/ic_launcher");
    final ios = DarwinInitializationSettings();

    final settings = InitializationSettings(android:  android , iOS:  ios);

    await _notifications.initialize(settings,
        onDidReceiveNotificationResponse:
            (payload) async {
            // click on noti and move to another page
              onNotifications.add(payload.payload);
            },
    );

  }


  //show immediately

  static void showNotification({
    int id = 0 ,
    String? title,
    String? body,
    String? payload,

  }) async {



    _notifications.show(id,
        title,
        body,
        await _notificationDetails(),
        payload:  payload);

  }



  static void showScheduleNotification({
    int id = 0 ,
    String? title,
    String? body,
    String? payload,
    required DateTime shcedauleDate,
  }) async {
    print("date from schedule");
    print(shcedauleDate);



    var zone =  tz.getLocation("Africa/Cairo");
    tz.setLocalLocation(zone);
    print(zone);
    _notifications.zonedSchedule(id,
        title,
        body,
        tz.TZDateTime.from(shcedauleDate, tz.local),

        await _notificationDetails(),
        uiLocalNotificationDateInterpretation:

        UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);

  }



}