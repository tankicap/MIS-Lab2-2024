import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  factory NotificationService() => _instance;

  NotificationService._internal();

  Future<void> initialize() async {

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);


    NotificationSettings settings = await _firebaseMessaging.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted permission for notifications");
    } else {
      print("User declined or has not accepted notification permission");
    }


    String? token = await _firebaseMessaging.getToken();
    if (token != null) {
      print("Device token: $token");

      await sendTokenToServer(token);
    } else {
      print("Failed to retrieve device token.");
    }


    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      print("Token refreshed: $newToken");
      sendTokenToServer(newToken);
    });


    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a message while the app is in the foreground!');
      print('Message data: ${message.data}');
      if (message.notification != null) {
        print('Notification: ${message.notification!.title}, ${message.notification!.body}');
        showLocalNotification(message.notification?.title, message.notification?.body);
      }
    });
  }


  Future<void> sendTokenToServer(String token) async {
    print("Sending token to server: $token");
  }


  Future<void> showLocalNotification(String? title, String? body) async {
    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'default',
          'Default Notifications',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );
  }


  Future<void> showDailyNotification(int id, String title, String body, Duration delay) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(delay),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_joke',
          'Daily Jokes',
          channelDescription: 'Daily joke reminders',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exact,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
