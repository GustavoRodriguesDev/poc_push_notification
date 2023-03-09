import 'package:firebase_messaging/firebase_messaging.dart';

class PushNitification {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  PushNitification._();

  Future<String> getPushNotificationToken() async {
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
      });
  }
}
