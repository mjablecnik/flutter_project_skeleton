import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_project_skeleton/core/app/utils.dart';

class CachedData {
  late final bool isLoaded;
  late final String deviceId;
  late final String appVersion;
  late final String appName;

  static final CachedData load = CachedData._initialize();

  Future<void> loadData() async {
    deviceId = await Utils.getDeviceId();
    appVersion = (await PackageInfo.fromPlatform()).version;
    appName = (await PackageInfo.fromPlatform()).appName;
  }

  CachedData._initialize() {
    loadData().then((value) => isLoaded = true);
  }
}