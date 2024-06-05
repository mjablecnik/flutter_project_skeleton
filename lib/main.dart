import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_skeleton/settings.dart';
import 'package:flutter_project_skeleton/view/widgets/app_theme.dart';
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

Widget app() {
  return TranslationProvider(
    child: ThemeProvider(
      child: const MyApp(),
    ),
  );
}

Future<void> run() async {
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
          child: app(),
        ),
      ),
    );
  } else {
    runApp(app());
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setup(isTest: false);
  run();
}
