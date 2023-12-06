import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_device_identifier/mobile_device_identifier.dart';
import 'package:android_device_id_generator/android_device_id_generator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_project_skeleton/core/app/global.dart';
import 'package:flutter_project_skeleton/core/singletons/getter.dart';

class Utils {
  static getDeviceId() async {
    final pref = await SharedPreferences.getInstance();
    String? deviceId = pref.getString(StoreKeys.deviceId);

    if (deviceId == null) {
      try {
        deviceId = await Get.methodChannel.invokeMethod('getSecureDeviceId');
      } on Exception catch (e) {
        Get.logger.warning(e);
        deviceId = await MobileDeviceIdentifier().getDeviceId();
        deviceId ??= generateAndroidDeviceId(secure: true);
      }

      pref.setString(StoreKeys.deviceId, deviceId!);
    }

    return deviceId;
  }

  static int getRandomNumber(int max) {
    return Random().nextInt(max);
  }

  static String getRandomString(int length) {
    const chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    var random = Random.secure();
    return List<String>.generate(length, (i) => chars[random.nextInt(chars.length)]).join();
  }

  static String getRandomHash() {
    final randomText = Utils.getRandomString(16) + DateTime.now().microsecondsSinceEpoch.toString();
    return Utils.generateHash(randomText);
  }

  static String generateHash(String text) {
    return sha1.convert(utf8.encode(text)).toString();
  }

  static bool get keyboardIsOpen => MediaQuery.of(Get.app.context).viewInsets.bottom == 0;
}
