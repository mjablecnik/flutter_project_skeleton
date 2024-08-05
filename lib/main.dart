import 'dart:io';

import 'package:catcher_2/catcher_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_skeleton/app.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_project_skeleton/core/app/global.dart';
import 'package:flutter_project_skeleton/core/i18n/translations.g.dart';

void setupNotifications() {
  AwesomeNotifications().initialize(
    //'resource://mipmap-mdpi/launcher_icon',
    null,
    [
      NotificationChannel(
        channelGroupKey: 'basic_channel_group',
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic notifications',
        defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.white,
      )
    ],
    // Channel groups are only visual and are not required
    channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: 'basic_channel_group',
        channelGroupName: 'Basic group',
      )
    ],
    debug: false,
  );
}

void setupSystemStyle() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }
}

Widget app() {
  return TranslationProvider(
    child: App(
      child: const MyApp(),
    ),
  );
}

void main() {
  Catcher2(
    runAppFunction: () {
      LocaleSettings.useDeviceLocale();
      setupSystemStyle();
      setupNotifications();
      runApp(app());
    },
    ensureInitialized: true,
    debugConfig: Catcher2Options(PageReportMode(), [ConsoleHandler()]),
    releaseConfig: Catcher2Options(
      PageReportMode(),
      [
        ConsoleHandler(),
      ],
    ),
  );
}
