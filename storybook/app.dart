import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_project_skeleton/core/app/cached_data.dart';
import 'package:flutter_project_skeleton/core/app/injector.dart';
import 'package:flutter_project_skeleton/core/i18n/translations.g.dart';
import 'package:flutter_project_skeleton/data/entities/product.dart';
import 'package:flutter_project_skeleton/logic/cubits/product_list_cubit.dart';
import 'package:flutter_project_skeleton/logic/services/rest_api_service.dart';
import 'package:flutter_project_skeleton/view/app/home_page.dart';
import 'package:flutter_project_skeleton/core/theme/modes.dart' as themeModes;
import 'package:flutter_project_skeleton/view/pages/error_page.dart';
import 'package:mocktail/mocktail.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

Storybook storybook() {
  return Storybook(
    wrapperBuilder: (context, child) {
      return TranslationProvider(
        child: Builder(
          builder: (context) {
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
        name: 'Pages/HomePage',
        description: 'First default page.',
        builder: (context) {
          final cachedData = MockCachedData();
          when(() => cachedData.appName).thenReturn('Meow');

          final restApiService = MockRestApiService();
          when(() => restApiService.getProducts()).thenAnswer((_) {
            return Future.delayed(
              const Duration(seconds: 3),
              () => [
                for (var i = 0; i < 20; i++)
                  Product(
                    id: i,
                    title: "Test Product $i",
                    description: "Test product $i",
                    thumbnail: Uri.parse("https://www.seznam.cz/$i"),
                  ),
              ],
            );
          });

          final inj = MockInjector();
          when(() => inj.get<CachedData>()).thenReturn(cachedData);
          when(() => inj.get<ProductListCubit>()).thenReturn(ProductListCubit(restApiService: restApiService));
          return HomePage(injector: inj);
        },
      ),
      Story(
        name: 'Widgets/Text',
        description: 'Simple text widget.',
        builder: (context) => const Center(child: Text('Simple text')),
      ),
    ],
  );
}
