import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_skeleton/settings.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:flutter_project_skeleton/app.dart';
import 'package:flutter_project_skeleton/core/app/global.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
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

setupSentry(Widget child) async {
  final settings = injector.get<Settings>();
  if (settings.sentryDsn != null) {
    await SentryFlutter.init(
      (options) {
        options.dsn = settings.sentryDsn;
        options.tracesSampleRate = 1.0;
      },
      appRunner: () => runApp(
        DefaultAssetBundle(
          bundle: SentryAssetBundle(),
          child: child,
        ),
      ),
    );
  } else {
    runApp(child);
  }
}

Widget app() {
  return TranslationProvider(
    child: const MyApp(),
  );
}

Future<void> setup({bool isTest = false}) async {
  LocaleSettings.useDeviceLocale();
  setupSystemStyle();
  setupNotifications();
  setupSentry(app());
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setup(isTest: false);
}
