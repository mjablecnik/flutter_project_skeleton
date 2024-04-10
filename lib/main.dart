import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_skeleton/settings.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:flutter_project_skeleton/app.dart';
import 'package:flutter_project_skeleton/core/app/global.dart';
import 'package:flutter_project_skeleton/core/i18n/translations.g.dart';

Future<void> setup({bool isTest = false}) async {

  LocaleSettings.useDeviceLocale();
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

Future<void> run() async {
  final settings = injector.get<Settings>();
  if (settings.sentryDsn != null) {
    await SentryFlutter.init(
      (options) {
        options.dsn = settings.sentryDsn;
        options.tracesSampleRate = 1.0;
      },
      appRunner: () => runApp(const MyApp()),
    );
  } else {
    runApp(DevicePreview(
      enabled: !kReleaseMode && settings.environment == Environment.preview,
      builder: (context) => const MyApp(),
    ));
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setup(isTest: false);
  run();
}
