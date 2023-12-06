import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_project_skeleton/core/app/global.dart';
import 'package:flutter_project_skeleton/core/singletons/getter.dart';
import 'package:flutter_project_skeleton/core/i18n/translations.g.dart';
import 'package:flutter_project_skeleton/view/pages/dialog_tester_page.dart';
import 'package:flutter_project_skeleton/view/pages/main_menu_page.dart';
import 'package:flutter_project_skeleton/view/pages/info_page.dart';
import 'package:flutter_project_skeleton/view/pages/login_page.dart';
import 'package:flutter_project_skeleton/view/pages/logo_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return TranslationProvider(
      child: ProviderScope(
        child: Builder(builder: (context) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: MaterialApp(
              locale: TranslationProvider.of(context).flutterLocale,
              supportedLocales: AppLocaleUtils.supportedLocales,
              localizationsDelegates: GlobalMaterialLocalizations.delegates,
              navigatorKey: App.get.navigatorKey,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color(0xff00d33c),
                  brightness: Brightness.light,
                ),
                useMaterial3: true,
              ),
              initialRoute: Routes.logo,
              routes: {
                Routes.logo: (context) => const LogoPage(),
                Routes.login: (context) => const LoginPage(),
                Routes.info: (context) => const InfoPage(),
                Routes.mainMenu: (context) => const MainMenuPage(),
                Routes.dialogTester: (context) => const DialogTester(),
              },
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.25),
                  child: child!,
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
