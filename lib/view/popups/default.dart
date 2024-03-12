import 'dart:async';

import 'package:flutter_project_skeleton/core/singletons/getter.dart';
import 'package:flutter_project_skeleton/core/i18n/translations.g.dart';
import 'package:vader_popup/vader_popup.dart';

class Popup {
  static Future<bool> showCloseDialog() async {
    final result = await Get.popup.question(
      title: t.dialogs.closeApp.title,
      message: t.dialogs.closeApp.message,
      type: PopupType.warning,
    );

    return result ?? false;
  }
}
