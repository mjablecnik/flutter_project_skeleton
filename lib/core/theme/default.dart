import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'default.tailor.dart';

@TailorMixin()
class DefaultTheme extends ThemeExtension<DefaultTheme> with _$DefaultThemeTailorMixin {
  const DefaultTheme({
    required this.background,
    required this.appBarColor,
  });

  @override
  final Color background;
  @override
  final Color appBarColor;
}

class ThemeModes {
  static final light = ThemeData(
    brightness: Brightness.light,
    extensions: const [
      DefaultTheme(
        background: Colors.white,
        appBarColor: Colors.deepOrange,
      )
    ],
  );
  static final dark = ThemeData(
    brightness: Brightness.dark,
    extensions: const [
      DefaultTheme(
        background: Colors.black,
        appBarColor: Colors.green,
      )
    ],
  );
}
