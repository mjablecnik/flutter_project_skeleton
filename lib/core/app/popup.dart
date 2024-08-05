import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_project_skeleton/core/app/global.dart';
import 'package:flutter_project_skeleton/core/i18n/translations.g.dart';
import 'package:flutter_project_skeleton/view/app/error_page.dart';
import 'package:vader_popup/vader_popup.dart';

class Popup {
  static Future<bool> showCloseDialog(BuildContext context) async {
    final result = await App.popup.question(
      context: context,
      title: t.dialogs.closeApp.title,
      message: t.dialogs.closeApp.message,
      type: PopupType.warning,
    );

    return result ?? false;
  }

  static Future<T?> showErrorPage<T>({
    required BuildContext context,
    required String title,
    required String message,
    String? errorDetails,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ErrorPage(
          title: title,
          description: message,
          errorDetails: errorDetails,
        ),
      ),
    );
  }
}
