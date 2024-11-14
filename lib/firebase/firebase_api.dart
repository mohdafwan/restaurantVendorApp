import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:restaurant_vendor_app/firebase/AuthMethods/AuthMethods.dart';
import 'package:torch_light/torch_light.dart';
import '../controllers/notification/notification_settrings_controller.dart';
import '../models/notification/notification_model.dart';
import '../views/notifaicatio/notifaication_view_page.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  final notificationTitle = message.notification?.title ?? "No title";
  final notificationBody = message.notification?.body ?? "No body";
  final dataPayload = message.data;

  print('Title: $notificationTitle');
  print('Body: $notificationBody');
  print('Payload: $dataPayload');
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _androidChannel = const AndroidNotificationChannel(
    'high_importance1_channel',
    'High Importance1 Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.max,
    playSound: true,
    enableVibration: true,
    enableLights: true,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();
  final NotificationsSettingsController settingsController =
      Get.find<NotificationsSettingsController>();

  void handleMessage(RemoteMessage? message) async {
    if (message == null) return;
    // if notification came with title = Session Expired then do use session logout
    if (message.notification?.title == 'Session Expired') {
      Get.find<AuthMethods>().signOut();
      return;
    }

    final notificationTitle = message.notification?.title ?? "No title";
    final notificationBody = message.notification?.body ?? "No body";
    // If 'orderReadyAlerts' is off, do not show the notification
    if (!settingsController.orderReadyAlerts.value) {
      print("Order Ready Alerts are disabled, skipping notification.");
      return;
    }
    final newNotification = NotificationModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      notificationAbout: notificationTitle,
      notificationMessage: notificationBody,
      notificationTime: DateTime.now(),
    );

    settingsController.notificationsList.add(newNotification);

    // Flashlight trigger if enabled
    if (settingsController.flashlightAlerts.value) {
      _triggerFlashlight();
    }
    // Handle new notification (e.g., add to a list)
    // Navigate to the notification view
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.to(() => NotificationView(
          notificationsList: settingsController.notificationsList));
    });
  }

  Future<void> _triggerFlashlight() async {
    try {
      await TorchLight.enableTorch();
      await Future.delayed(const Duration(seconds: 1)); // Flash for 1 second
      await TorchLight.disableTorch();
      print("Flashlight triggered.");
    } catch (e) {
      print("Error enabling flashlight: $e");
    }
  }

  Future initLocalNotifications() async {
    const android =
        AndroidInitializationSettings('@drawable/launch_background');
    const settings = InitializationSettings(android: android);
    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        final message = RemoteMessage.fromMap(jsonDecode(response.payload!));
        handleMessage(message);
      },
    );
    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future<void> initPushNotification() async {
    // final isVibrationEnabled = settingsController.vibrationAlerts.value;
    // final isSoundEnabled = settingsController.orderReadyAlerts.value;
    // final isFlashLightEnabled = settingsController.flashlightAlerts.value;

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: settingsController.orderReadyAlerts.value,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      final data = message.data;
      if (notification == null) return;

      BigPictureStyleInformation? bigPictureStyleInformation;
      if (data['imageUrl'] != null) {
        bigPictureStyleInformation = BigPictureStyleInformation(
          FilePathAndroidBitmap(data['imageUrl']), // Ensure this path is valid
          largeIcon: FilePathAndroidBitmap(data['imageUrl']), // Same as above
          contentTitle: notification.title,
          summaryText: notification.body,
        );
      }
      if (settingsController.orderReadyAlerts.value) {
        _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _androidChannel.id,
              _androidChannel.name,
              channelDescription: _androidChannel.description,
              icon: '@drawable/launch_background',
              importance: Importance.max,
              priority: Priority.high,
              visibility: NotificationVisibility.public,
              styleInformation: bigPictureStyleInformation,
              enableLights: settingsController.flashlightAlerts.value,
              enableVibration: settingsController.vibrationAlerts.value,
              playSound: settingsController.orderReadyAlerts.value,
              vibrationPattern: settingsController.vibrationAlerts.value
                  ? Int64List.fromList([0, 500, 1000])
                  : null,
            ),
          ),
          payload: jsonEncode(message.toMap()),
        );
        // Flashlight trigger if enabled
        if (settingsController.flashlightAlerts.value) {
          _triggerFlashlight();
        }
      } else {
        print("Order Ready Alerts disabled, skipping notification.");
      }
    });
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    if (fCMToken != null) {
      Get.find<AuthMethods>().fcmToken = fCMToken; // store fcm token
      if (kDebugMode) {
        print('saved token: $fCMToken');
      }
    }
    await initPushNotification();
    await initLocalNotifications();
  }
}
