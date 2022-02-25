import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// package : flutter_local_notifications: ^9.3.1

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin plugin =
      FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> initNotification() async {
    const AndroidInitializationSettings androidInitSetting =
        AndroidInitializationSettings("@drawable/ic_launcher");

    const InitializationSettings initSettings =
        InitializationSettings(android: androidInitSetting);

    await plugin.initialize(initSettings);
  }

  Future<void> showNotification(int id, String title, String body) async {
    await plugin.show(
      id,
      title,
      body,
      const NotificationDetails(
          android: AndroidNotificationDetails(
        'main_channel',
        'Main Channel',
        channelDescription: 'Main channel notifications',
        importance: Importance.max,
        priority: Priority.max,
        playSound: true,
      )),
    );
  }
}
