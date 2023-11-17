import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:itu_dev/Controllers/NotificationPageController.dart';
import 'package:itu_dev/Controllers/TipsPageController.dart';
import 'package:shared_preferences/shared_preferences.dart';


class NotificationService {

  final NotificationPageController _controllerNot = NotificationPageController();
  final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

  static bool areNotificationsEnabled = true;
  static const String notificationsKey = 'notificationsEnabled';

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings('icon');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    areNotificationsEnabled = prefs.getBool(notificationsKey) ?? true;

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: (int id, String? title, String? body,
            String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse response) async {});

    startNotificationTimer();
  }

  void startNotificationTimer() {
    final _notificationService = NotificationService();
    Timer.periodic(const Duration(seconds: 10), (timer) async {
      if (areNotificationsEnabled) {
        int id = DateTime
            .now()
            .millisecondsSinceEpoch ~/ 1000;
        String title = 'Read Your Financial Advice!';
        String formattedDateTime = DateFormat('yyyy-MM-dd HH:mm').format(
            DateTime.now().toLocal());
        String tipName = (await TipsPageController().getRandomTip()).title;
        String body = 'Financial Tip of the Day: ${tipName}\nTime of receipt: ${formattedDateTime}';
        _notificationService.showNotification(
          id: id,
          title: title,
          body: body,
        );
        _controllerNot.save(id, title, body);
      }
    });
  }

  static void toggleNotifications(bool enable) async{
    areNotificationsEnabled = enable;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(notificationsKey, areNotificationsEnabled);
  }

  static bool getNotificationsEnabled() {
    return areNotificationsEnabled;
  }


  Future showNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }
}



