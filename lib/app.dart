import 'package:flutter/material.dart';
import 'package:flutter_project_skeleton/core/handlers/notification_handler.dart';
import 'package:flutter_project_skeleton/core/theme/modes.dart' as themeModes;
import 'package:flutter_project_skeleton/logic/services/theme_service.dart';
import 'package:flutter_project_skeleton/view/features/about/about_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_project_skeleton/core/app/global.dart';
import 'package:flutter_project_skeleton/core/i18n/translations.g.dart';
import 'package:flutter_project_skeleton/view/app/home_page.dart';
import 'package:flutter_project_skeleton/view/app/auth_page.dart';
import 'package:flutter_project_skeleton/view/app/index_page.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeModeHandler(
      manager: context.injector.get<ThemeService>(),
      builder: (ThemeMode themeMode) {
        return NotificationHandler(
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: MaterialApp(
              locale: TranslationProvider.of(context).flutterLocale,
              supportedLocales: AppLocaleUtils.supportedLocales,
              localizationsDelegates: GlobalMaterialLocalizations.delegates,
              debugShowCheckedModeBanner: false,
              theme: themeModes.light,
              darkTheme: themeModes.dark,
              themeMode: themeMode,
              initialRoute: Routes.index,
              navigatorKey: App.navigatorKey,
              routes: {
                Routes.index: (context) => const IndexPage(),
                Routes.about: (context) => const AboutPage(),
                Routes.auth: (context) => const AuthPage(),
                Routes.home: (context) => HomePage(injector: context.injector),
              },
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
                  child: child!,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
