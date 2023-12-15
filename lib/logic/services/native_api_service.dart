import 'package:flutter/services.dart';
import 'package:flutter_project_skeleton/core/app/global.dart';
import 'package:flutter_project_skeleton/core/singletons/getter.dart';

class NativeApiService {
  NativeApiService() {
    _methodChannel = const MethodChannel(Constants.methodChannel);
  }

  late final MethodChannel _methodChannel;

  Future<String?> getSecureDeviceId() async {
    try {
      return await _methodChannel.invokeMethod('getSecureDeviceId');
    } on Exception catch (e) {
      Get.logger.error(e);
      return null;
    }
  }
}
