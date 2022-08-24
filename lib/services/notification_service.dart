import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';

typedef NotificationHandler = Future<dynamic> Function(
    Map<String, dynamic> message);

class NotificationService {
  factory NotificationService() => instance;

  NotificationService._internal();

  static final NotificationService instance = NotificationService._internal();

  PushNotificationListener? _listener;

  bool _isConfigured = false;

  // Methods

  Future initialize() async {
    if (_isConfigured) {
      return;
    }
    _isConfigured = true;
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        _listener?.onReceivedNotification(message.notification?.body ?? '');
      }
    });

    if (Platform.isIOS) {
      await FirebaseMessaging.instance.requestPermission();
    }
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('messaging message');
      print(message.toMap());
      _listener?.onReceivedNotification(message.toMap().toString());
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('messaging open');
      print(message.toMap());
      _listener?.onReceivedNotification(message.toMap().toString());
    });
  }

  void setListener(PushNotificationListener listener) {
    _listener = listener;
  }
}

extension NotificationServiceUtils on NotificationService {
  Future<String> getToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    return token ?? '';
  }

  Future<bool> subscribeTopic(String topic) async {
    if (topic.isEmpty) {
      return false;
    }
    await FirebaseMessaging.instance
        .subscribeToTopic(topic)
        .catchError((error) {
      print("subscribe error: " + error);
      return false;
    });
    return true;
  }

  Future<bool> unsubscribeTopic(String topic) async {
    if (topic.isEmpty) {
      return false;
    }
    await FirebaseMessaging.instance
        .unsubscribeFromTopic(topic)
        .catchError((error) {
      print("un-subscribe error: " + error);
      return false;
    });
    return true;
  }

  Future checkUserGrantNotificationPermission() async {
    final PermissionStatus status = await Permission.notification.status;
    if (status.isGranted) {
      return;
    }
    _listener?.onShowPermissionPopup();
  }
}

enum NotificationChannel {
  onMessage,
  onLaunch,
  onResume,
  onBackgroundMessage,
}

extension NotificationChannelExtension on NotificationChannel {
  String get key {
    switch (this) {
      case NotificationChannel.onMessage:
        return 'onMessage';
      case NotificationChannel.onLaunch:
        return 'onLaunch';
      case NotificationChannel.onResume:
        return 'onResume';
      case NotificationChannel.onBackgroundMessage:
        return 'onBackgroundMessage';
      default:
        return '';
    }
  }
}

abstract class PushNotificationListener {
  void onReceivedNotification(dynamic payload);

  void onShowPermissionPopup();
}
