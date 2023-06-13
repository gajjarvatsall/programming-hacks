import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:programming_hacks/app_theme/text_theme.dart';

class NotificationService {
  static int createUniqueId() {
    return DateTime.now().millisecondsSinceEpoch.remainder(20);
  }

  static Future<void> notificationPermission(BuildContext context) async {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) async {
      if (!isAllowed) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Allow Notifications"),
                content: Text("Our application would like to send you notification"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Deny",
                        style: CustomTextTheme.textButtonText.copyWith(color: Colors.grey),
                      )),
                  TextButton(
                      onPressed: () async {
                        await AwesomeNotifications()
                            .requestPermissionToSendNotifications()
                            .then((_) => {Navigator.pop(context)});
                      },
                      child: Text(
                        "Allow",
                        style: CustomTextTheme.textButtonText.copyWith(color: Colors.pink),
                      )),
                ],
              );
            });
      }
    });
  }

  static Future<void> welcomeNotification() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 10,
          channelKey: 'basic_channel',
          title: 'Welcome to ProHacks',
          body: 'Hacks to make your programming easy'),
    );
  }

  static Future<void> scheduledNotification() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 12,
          channelKey: 'scheduled_channel',
          title: "Did you missed something !?",
          body: "Don't want to see the latest hacks of different languages"),
      actionButtons: [
        NotificationActionButton(key: "OPEN", label: "Open"),
      ],
      schedule: NotificationCalendar(second: 5),
    );
  }
}
