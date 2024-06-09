import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_project_skeleton/core/i18n/translations.g.dart';
import 'package:flutter_project_skeleton/view/pages/error_page.dart';
import 'package:flutter_project_skeleton/core/theme/modes.dart' as themeModes;
import 'package:storybook_flutter/storybook_flutter.dart';

class StorybookApp extends StatelessWidget {
  const StorybookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Storybook(
      wrapperBuilder: (context, child) => TranslationProvider(
        child: Builder(builder: (context) {
          return MaterialApp(
            locale: TranslationProvider.of(context).flutterLocale,
            supportedLocales: AppLocaleUtils.supportedLocales,
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
            debugShowCheckedModeBanner: false,
            theme: themeModes.light,
            darkTheme: themeModes.dark,
            home: Scaffold(
              body: Center(
                child: child,
              ),
            ),
          );
        }),
      ),
      plugins: initializePlugins(
        enableContents: true,
        enableKnobs: true,
        enableThemeMode: true,
        enableDeviceFrame: true,
        contentsSidePanel: false,
        knobsSidePanel: false,
      ),
      stories: [
        Story(
          name: 'Pages/ErrorPage',
          description: 'Page for show errors.',
          builder: (context) => ErrorPage(
            title: context.knobs.text(
              label: 'Title',
              initial: 'Error',
            ),
            description: context.knobs.text(
              label: 'Description',
              initial: 'Nastala nějaká chyba',
            ),
          ),
        ),
        Story(
          name: 'Widgets/Text',
          description: 'Simple text widget.',
          builder: (context) => const Center(child: Text('Simple text')),
        ),
      ],
    );
  }
}