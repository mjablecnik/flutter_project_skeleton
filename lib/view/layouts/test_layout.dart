import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_project_skeleton/core/i18n/translations.g.dart';
import 'package:flutter_project_skeleton/core/theme/modes.dart' as themeModes;

class TestLayout extends StatelessWidget {
  const TestLayout({super.key, required this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      //debugShowCheckedModeBanner: false,
      theme: themeModes.light,
      darkTheme: themeModes.dark,
      home: Scaffold(
        body: Center(
          child: child,
        ),
      ),
    );
  }
}
