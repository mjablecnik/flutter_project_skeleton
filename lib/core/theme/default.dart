import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'default.tailor.dart';

@TailorMixin()
class DefaultTheme extends ThemeExtension<DefaultTheme> with _$DefaultThemeTailorMixin {
  const DefaultTheme({
    required this.background,
    required this.appBarColor,
    required this.loginPage,
  });

  @override
  final Color background;
  @override
  final Color appBarColor;

  @override
  @themeExtension
  final LoginPageTheme loginPage;
}

@tailorMixinComponent
class LoginPageTheme extends ThemeExtension<LoginPageTheme> with _$LoginPageThemeTailorMixin {
  const LoginPageTheme({required this.loginButton});

  @override
  final Color loginButton;
}

class ThemeModes {
  static final light = ThemeData(
    brightness: Brightness.light,
    extensions: const [
      DefaultTheme(
        background: Colors.white,
        appBarColor: Colors.deepOrange,
        loginPage: LoginPageTheme(
          loginButton: Colors.yellow,
        ),
      )
    ],
  );
  static final dark = ThemeData(
    brightness: Brightness.dark,
    extensions: const [
      DefaultTheme(
        background: Colors.black,
        appBarColor: Colors.green,
        loginPage: LoginPageTheme(
          loginButton: Colors.pink,
        ),
      )
    ],
  );
}
