import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_project_skeleton/core/app/global.dart';
import 'package:flutter_project_skeleton/core/i18n/translations.g.dart';
import 'package:vader_popup/vader_popup.dart';

class Popup {
  static Future<bool> showCloseDialog(BuildContext context) async {
    final result = await popup.question(
      context: context,
      title: t.dialogs.closeApp.title,
      message: t.dialogs.closeApp.message,
      type: PopupType.warning,
    );

    return result ?? false;
  }
}
