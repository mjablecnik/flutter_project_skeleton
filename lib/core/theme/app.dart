import 'package:flutter/material.dart';
import 'package:flutter_project_skeleton/core/theme/pages.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'app.tailor.dart';

@TailorMixin()
class AppTheme extends ThemeExtension<AppTheme> with _$AppThemeTailorMixin {
  const AppTheme({
    required this.layout,
    required this.loginPage,
    required this.errorPage,
  });

  @override
  @themeExtension
  final LayoutTheme layout;

  @override
  @themeExtension
  final LoginPageTheme loginPage;

  @override
  @themeExtension
  final ErrorPageTheme errorPage;
}
