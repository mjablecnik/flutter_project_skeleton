import 'package:flutter/material.dart';
import 'package:flutter_project_skeleton/core/theme/components.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'pages.tailor.dart';

@tailorMixinComponent
class LayoutTheme extends ThemeExtension<LayoutTheme> with _$LayoutThemeTailorMixin {
  const LayoutTheme({
    required this.backgroundColor,
    required this.appBarColor,
    required this.appBarText,
  });

  @override
  final Color backgroundColor;

  @override
  final Color appBarColor;

  @override
  final TextStyle appBarText;
}

@tailorMixinComponent
class LoginPageTheme extends ThemeExtension<LoginPageTheme> with _$LoginPageThemeTailorMixin {
  const LoginPageTheme({
    required this.button,
    required this.titleText,
  });

  @override
  final ButtonComponentTheme button;
  @override
  final TextStyle titleText;
}

@tailorMixinComponent
class ErrorPageTheme extends ThemeExtension<ErrorPageTheme> with _$ErrorPageThemeTailorMixin {
  const ErrorPageTheme({
    required this.titleText,
    required this.descriptionText,
    required this.detailText,
    required this.detailTextButton,
    required this.detailTextButtonIcon,
  });

  @override
  final TextStyle titleText;

  @override
  final TextStyle descriptionText;

  @override
  final TextStyle detailText;

  @override
  final TextStyle detailTextButton;

  @override
  final Color detailTextButtonIcon;
}
