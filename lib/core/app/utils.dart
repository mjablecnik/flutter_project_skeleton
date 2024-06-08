import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/widgets.dart';

class Utils {
  static int getRandomNumber(int max) => Random().nextInt(max);

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

  static bool isKeyboardOpen(BuildContext context) => MediaQuery.of(context).viewInsets.bottom == 0;
}
