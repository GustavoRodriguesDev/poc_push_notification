import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class CustomNotification {
  final int id;
  final String title;
  final String body;
  final String? payload;
  final RemoteMessage? remoteMessage;

  CustomNotification({
    required this.id,
    required this.title,
    required this.body,
    this.payload,
    this.remoteMessage,
  });
}

class LocalNotificationService {
  FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  late AndroidNotificationDetails androidDetails;
  LocalNotificationService() {
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _setupAndroidDetails();
    _initializeNotifications();
  }

  void _setupAndroidDetails() {
    androidDetails = const AndroidNotificationDetails(
      'Teste de notificação',
      'test',
      importance: Importance.max,
      priority: Priority.max,
      enableVibration: true,
    );
  }

  void _initializeNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    // Fazer: macOs, iOS, Linux...
    await localNotificationsPlugin.initialize(
      const InitializationSettings(
        android: android,
      ),
    );
  }

  void showLocalNotification(CustomNotification notification) {
    localNotificationsPlugin.show(
      notification.id,
      notification.title,
      notification.body,
      NotificationDetails(
        android: androidDetails,
      ),
      payload: notification.payload,
    );
  }
}
