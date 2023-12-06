import 'package:dialog_kh/dialog_kh.dart';
import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:flutter_project_skeleton/core/app/exceptions.dart';
import 'package:flutter_project_skeleton/core/app/global.dart';
import 'package:flutter_project_skeleton/core/singletons/getter.dart';
import 'package:flutter_project_skeleton/core/i18n/translations.g.dart';

class Popup {
  static Future<bool> showCloseDialog() async {
    return await showDialog(
      context: Get.app.context,
      builder: (context) => AlertDialog(
        title: Text(t.dialogs.closeApp.title),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        content: Wrap(
          runSpacing: 12,
          children: [Text(t.dialogs.closeApp.message)],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.app.navigator.pop(false),
            child: Text(
              t.dialogs.closeApp.no.toUpperCase(),
              style: const TextStyle(color: Colors.blue),
            ),
          ),
          TextButton(
            onPressed: () => Get.app.navigator.pop(true),
            child: Text(
              t.dialogs.closeApp.yes.toUpperCase(),
              style: const TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    ) as bool;
  }

  static void showFailure(ServerException failure) => failure.showPopup();

  static Future warning<T>({
    required String title,
    required String message,
  }) {
    Get.logger.log("Dialog: $message", logLevel: LogLevel.warning);
    return Popup.dialog(
      Get.app.context,
      title: title,
      message: message,
      type: DialogType.warning,
    );
  }

  static Future error<T>({
    required String title,
    required String message,
    String? errorDetails,
  }) {
    Get.logger.log("Dialog: $message", logLevel: LogLevel.error);
    if (errorDetails != null) Get.logger.log(errorDetails, logLevel: LogLevel.error);

    return Popup.dialog(
      Get.app.context,
      title: title,
      message: message,
      type: DialogType.error,
    );
  }

  static Future dialog(
    BuildContext context, {
    required String title,
    required String message,
    DialogType type = DialogType.info,
    PopupDialogInput? input,
    PopupDialogActions? submitActions,
  }) {
    final lightTheme = Theme.of(context).brightness == Brightness.light;
    final rightButtonColor;
    final leftButtonColor;
    final backgroundColor;
    final iconColor;
    final icon;

    switch (type) {
      case DialogType.info:
        rightButtonColor = lightTheme ? Colors.blue : const Color(0xff1e4f80);
        leftButtonColor = lightTheme ? Colors.grey : const Color(0x4f344146);
        backgroundColor = lightTheme ? Colors.white : const Color(0xff7f91a4);
        iconColor = lightTheme ? Colors.blue : const Color(0xff1e4f80);
        icon = Icons.info;
      case DialogType.error:
        rightButtonColor = lightTheme ? Colors.red : const Color(0xff5b131b);
        leftButtonColor = lightTheme ? Colors.grey : const Color(0x30480e15);
        backgroundColor = lightTheme ? Colors.white : const Color(0xff8d6262);
        iconColor = lightTheme ? Colors.red : const Color(0xff480e14);
        icon = Icons.error;
      case DialogType.warning:
        rightButtonColor = lightTheme ? Colors.orange : const Color(0xffc26423);
        leftButtonColor = lightTheme ? Colors.grey : const Color(0x5273665b);
        backgroundColor = lightTheme ? Colors.white : const Color(0xffa88872);
        iconColor = lightTheme ? Colors.orange : const Color(0xff98470f);
        icon = Icons.warning;
      case DialogType.success:
        rightButtonColor = lightTheme ? Colors.green : const Color(0xff175719);
        leftButtonColor = lightTheme ? Colors.grey : const Color(0x4c344638);
        backgroundColor = lightTheme ? Colors.white : const Color(0xff726972);
        iconColor = lightTheme ? Colors.green : const Color(0xff0f3f13);
        icon = Icons.check_circle;
    }

    final titleColor = lightTheme ? Colors.black : Colors.black;
    final descriptionColor = lightTheme ? Colors.black87 : Colors.black87;
    final buttonTextColor = lightTheme ? Colors.white : Colors.black;

    return DialogKh.alertDialogKh(
      context: context,
      isAutoClosed: false,
      disableBtn: false,
      header: Icon(icon, color: iconColor, size: 70),
      onCancel: () {
        Get.app.navigator.pop(false);
        submitActions?.cancel.onPressed?.call();
      },
      onConfirm: () {
        Get.app.navigator.pop(true);
        submitActions?.confirm.onPressed?.call();
      },
      labelColorBtnL: buttonTextColor,
      backgroundColorBtnL: leftButtonColor,
      descColor: descriptionColor,
      backgroundColor: backgroundColor,
      titleColor: titleColor,
      btnLabelL: submitActions?.cancel.text ?? "Cancel",
      btnLabelR: submitActions?.confirm.text ?? "OK",
      labelColorBtnR: buttonTextColor,
      backgroundColorBtnR: rightButtonColor,
      bottom: const SizedBox(),
      title: title,
      description: message,
      radius: 20,
    );
  }
}

class PopupDialogInput {
  const PopupDialogInput({
    this.hintText = "",
    this.initText = "",
  });

  final String hintText;
  final String initText;
}

class PopupDialogAction {
  const PopupDialogAction({
    this.onPressed,
    required this.text,
  });

  final VoidCallback? onPressed;
  final String text;
}

class PopupDialogActions {
  const PopupDialogActions({
    required this.confirm,
    required this.cancel,
  });

  final PopupDialogAction confirm;
  final PopupDialogAction cancel;
}
