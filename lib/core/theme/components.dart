import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'components.tailor.dart';

@tailorMixinComponent
class ButtonComponentTheme extends ThemeExtension<ButtonComponentTheme> with _$ButtonComponentThemeTailorMixin {
  const ButtonComponentTheme({
    required this.backgroundColor,
    required this.textColor,
    required this.textStyle,
  });

  @override
  final Color backgroundColor;

  @override
  final Color textColor;

  @override
  final TextStyle textStyle;
}
