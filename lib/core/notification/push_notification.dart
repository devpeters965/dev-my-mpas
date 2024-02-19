
import 'dart:math';

import 'package:onesignal_flutter/onesignal_flutter.dart';




class NotificationPush {

  NotificationPush._();
  static Future<void> initPushNotification() async {

    await OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    await OneSignal.shared.setAppId('4ae76a24-eeed-4979-93b5-a35d8ca13996');
     OneSignal.shared.promptUserForPushNotificationPermission().then((pushnotification) {
        log("user permission $pushnotification" as num );
       });
  }
}