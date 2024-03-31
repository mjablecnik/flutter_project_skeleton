import 'package:flutter_project_skeleton/core/app/global.dart';
import 'package:flutter_project_skeleton/core/singletons/getter.dart';
import 'package:flutter_project_skeleton/core/singletons/secure_storage.dart';
import 'package:flutter_project_skeleton/data/entities/user.dart';

class StorageService {
  StorageService() {
    _storage = Get.storage;
  }

  late final SecureStorage _storage;

  Future<User?> getLoggedUser() async {
    try {
      return User.fromJson(await _storage.getMap(StorageKey.loggedUser.name));
    } catch (e) {
      Get.logger.error(e);
      return null;
    }
  }

  Future<void> saveLoggedUser(User? user) {
    if (user != null) {
      return _storage.saveMap(StorageKey.loggedUser.name, user.toJson());
    } else {
      return _storage.remove(StorageKey.loggedUser.name);
    }
  }

  Future<void>  saveDeviceId(String deviceId) {
    return _storage.saveString(StorageKey.deviceId.name, deviceId);
  }

  Future<String?> getDeviceId() async {
    String? deviceId = await _storage.getString(StorageKey.deviceId.name);
    return deviceId;
  }
}
