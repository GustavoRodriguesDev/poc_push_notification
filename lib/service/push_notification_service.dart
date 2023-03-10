import 'package:firebase_messaging/firebase_messaging.dart';

import 'local_notification_service.dart';

class PushNitificationService {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  final LocalNotificationService _localNotificationService =
      LocalNotificationService();

  void initalizeServicePushNotification() {
    messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    getDeviceTokenForPushNotification();
    _onMessage();
  }

  Future<String> getDeviceTokenForPushNotification() async {
    try {
      var token = await messaging.getToken();
      print('----------------');
      print(token);
      return token!;
    } catch (e) {
      rethrow;
    }
  }

  void _onMessage() {
    FirebaseMessaging.onMessage
      ..listen((event) {
        RemoteNotification? remoteNotification = event.notification;
        AndroidNotification? androidNotification = event.notification?.android;

        if (remoteNotification != null && androidNotification != null) {
          _localNotificationService.showLocalNotification(
            CustomNotification(
              id: androidNotification.hashCode,
              title: remoteNotification.title!,
              body: remoteNotification.body!,
              payload: event.data['route'] ?? '',
            ),
          );
        }
      });
  }
}
