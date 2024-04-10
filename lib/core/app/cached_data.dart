import 'package:android_device_id_generator/android_device_id_generator.dart';
import 'package:flutter_project_skeleton/core/app/global.dart';
import 'package:flutter_project_skeleton/core/clients/secure_storage.dart';
import 'package:mobile_device_identifier/mobile_device_identifier.dart';
import 'package:package_info_plus/package_info_plus.dart';

class CachedData {
  late final bool isLoaded;
  late final String deviceId;
  late final String appVersion;
  late final String appName;

  late final SecureStorage _storage;

  CachedData(SecureStorage storage) {
    _storage = storage;
    loadData().then((value) => isLoaded = true);
  }

  Future<void> loadData() async {
    deviceId = await _getDeviceId();
    appVersion = (await PackageInfo.fromPlatform()).version;
    appName = (await PackageInfo.fromPlatform()).appName;
  }

  _getDeviceId() async {
    String? deviceId = await _storage.getString(StoreKeys.deviceId);

    if (deviceId == null) {
      deviceId = await MobileDeviceIdentifier().getDeviceId();
      deviceId ??= generateAndroidDeviceId(secure: true);

      _storage.saveString(StoreKeys.deviceId, deviceId);
    }

    return deviceId;
  }
}