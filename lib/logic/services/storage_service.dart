import 'dart:convert';

import 'package:flutter_project_skeleton/core/app/global.dart';
import 'package:flutter_project_skeleton/core/singletons/getter.dart';
import 'package:flutter_project_skeleton/data/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  StorageService() {
    _storage = Get.cached.storage;
  }

  late final SharedPreferences _storage;

  Future<User?> getLoggedUser() async {
    try {
      return User.fromJson(json.decode(_storage.getString(StorageKey.loggedUser.name).toString()));
    } catch (e) {
      Get.logger.error(e);
      return null;
    }
  }

  Future<void> saveLoggedUser(User? user) async {
    if (user != null) {
      await _storage.setString(StorageKey.loggedUser.name, json.encode(user.toJson()));
    } else {
      _storage.remove(StorageKey.loggedUser.name);
    }
  }


  String? getDeviceId() {
    String? deviceId = _storage.getString(StorageKey.deviceId.name);
    return deviceId;
  }
}
