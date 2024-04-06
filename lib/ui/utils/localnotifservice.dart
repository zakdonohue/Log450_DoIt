import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // Initialize native android notification
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    // await flutterLocalNotificationsPlugin.initialize(
    //   initializationSettings
    // );

    tz.initializeTimeZones(); // <------

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<void> showNotificationAndroid(
      String title, String value) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel_id', 'Channel Name',
            channelDescription: 'Channel Description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');

    int notification_id = 1;
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        12345,
        "A Notification From My App",
        "This notification is brought to you by Local Notifcations Package",
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 30)),
        notificationDetails,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);

    print("Notif tick");
  }

  // static Future<void> display(String message) async {
  //   // To display the notification in device
  //   try {
  //     print(message.notification!.android!.sound);
  //     final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  //     NotificationDetails notificationDetails = NotificationDetails(
  //       android: AndroidNotificationDetails(
  //           message.notification!.android!.sound ?? "Channel Id",
  //           message.notification!.android!.sound ?? "Main Channel",
  //           groupKey: "gfg",
  //           color: Colors.green,
  //           importance: Importance.max,
  //           sound: RawResourceAndroidNotificationSound(
  //               message.notification!.android!.sound ?? "gfg"),

  //           // different sound for
  //           // different notification
  //           playSound: true,
  //           priority: Priority.high),
  //     );
  //     await flutterLocalNotificationsPlugin.show(id, message.notification?.title,
  //         message.notification?.body, notificationDetails,
  //         payload: message.data['route']);
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }
}
