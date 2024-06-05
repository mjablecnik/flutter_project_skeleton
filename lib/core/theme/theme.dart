import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme.freezed.dart';

part 'theme.g.dart';

enum ThemeName { main }

@freezed
class Theme with _$Theme {
  const Theme._();

  const factory Theme({
    required ThemeName name,
    required ThemeMode mode,
  }) = _Theme;

  factory Theme.standard() {
    return const Theme(
      name: ThemeName.main,
      mode: ThemeMode.system,
    );
  }

  factory Theme.fromJson(Map<String, Object?> json) => _$ThemeFromJson(json);
}
