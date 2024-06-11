import 'package:flutter/material.dart';
import 'package:flutter_project_skeleton/core/i18n/translations.g.dart';
import 'package:flutter_project_skeleton/view/layouts/test_layout.dart';
import 'package:flutter_project_skeleton/view/pages/error_page.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

Storybook storybook() {
  return Storybook(
    wrapperBuilder: (context, child) {
      return TranslationProvider(
        child: TestLayout(
          child: child,
        ),
      );
    },
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
