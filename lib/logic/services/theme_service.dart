import 'package:flutter_project_skeleton/core/app/global.dart';
import 'package:flutter_project_skeleton/core/clients/secure_storage.dart';
import 'package:theme_mode_handler/theme_mode_manager_interface.dart';

class ThemeService implements IThemeModeManager {
  ThemeService({required SecureStorage storage}) {
    _storage = storage;
  }

  late final SecureStorage _storage;

  @override
  Future<String> loadThemeMode() async {
    return (await _storage.getString(StorageKey.themeMode.name)) ?? "system";
  }

  @override
  Future<bool> saveThemeMode(String value) async {
    try {
      await _storage.saveString(StorageKey.themeMode.name, value);
      return true;
    } catch (e) {
      return false;
    }
  }
}