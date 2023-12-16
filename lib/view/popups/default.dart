import 'dart:async';

import 'package:dialog_kh/dialog_kh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_skeleton/core/app/exceptions.dart';
import 'package:flutter_project_skeleton/core/app/global.dart';
import 'package:flutter_project_skeleton/core/singletons/getter.dart';
import 'package:flutter_project_skeleton/core/i18n/translations.g.dart';
import 'package:flutter_project_skeleton/view/layouts/modal_layout.dart';
import 'package:talker_flutter/talker_flutter.dart';

class Popup {
  static Future<bool> showCloseDialog() async {
    final result = await showDialog(
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
            onPressed: () {
              Get.app.navigator.pop(false);
            },
            child: Text(
              t.dialogs.closeApp.no.toUpperCase(),
              style: const TextStyle(color: Colors.blue),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.app.navigator.pop(true);
            },
            child: Text(
              t.dialogs.closeApp.yes.toUpperCase(),
              style: const TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    ) as bool?;
    return result ?? false;
  }

  static Future<({String code, String name})?> chooseItem({
    required String title,
    required List<({String code, String name})> items,
    ({String code, String name})? currentItem,
  }) async {
    final result = await showDialog(
      context: Get.app.context,
      builder: (context) => AlertDialog(
        title: Text(title),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        content: SizedBox(
          width: 350,
          height: 400,
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: items.length,
            separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 8),
            itemBuilder: (BuildContext context, int index) {
              ({String code, String name}) item = items[index];
              return InkWell(
                onTap: () {
                  Navigator.of(context).pop(item);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.greenAccent.withOpacity(0.15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(children: [
                      Icon(currentItem?.code == item.code ? Icons.radio_button_on : Icons.radio_button_off),
                      const SizedBox(width: 16),
                      Expanded(child: Text(item.name)),
                    ]),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    ) as ({String code, String name})?;
    return result;
  }

  static Future<T?> modalPage<T>(
    BuildContext context, {
    required String title,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    bool isScrollable = false,
    required Widget child,
  }) {
    return showModalBottomSheet(
      context: context,
      enableDrag: false,
      isScrollControlled: true,
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.95,
        child: ModalLayout(
          title: title,
          isScrollable: isScrollable,
          padding: padding,
          body: Material(
            child: child,
          ),
        ),
      ),
    );
  }

  static Future modal<T>(
    BuildContext context, {
    required String title,
    double heightFactor = 0.8,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    bool isScrollable = false,
    bool showIcon = true,
    DialogType type = DialogType.info,
    PopupDialogActions? submitActions,
    required Widget child,
  }) {
    final lightTheme = Theme.of(context).brightness == Brightness.light;
    final rightButtonColor = lightTheme ? Colors.blue : const Color(0xff1e4f80);
    final leftButtonColor = lightTheme ? Colors.grey : const Color(0x4f344146);
    final iconColor = lightTheme ? Colors.blue : const Color(0xff1e4f80);
    const icon = Icons.info;

    final titleColor = lightTheme ? Colors.black : Colors.black;
    final descriptionColor = lightTheme ? Colors.black87 : Colors.black87;
    final buttonTextColor = lightTheme ? Colors.white : Colors.black;

    final cancelLabel = submitActions?.cancel.text ?? "Cancel";
    final confirmLabel = submitActions?.confirm.text ?? "OK";

    return DialogKh.bottomSheetKh(
      context: context,
      heightFactor: heightFactor,
      title: title,
      body: child,
      titleColor: titleColor,
      descColor: descriptionColor,
      labelColorBtnR: buttonTextColor,
      labelColorBtnL: buttonTextColor,
      btnLabelL: cancelLabel,
      btnLabelR: confirmLabel,
      backgroundColorBtnL: leftButtonColor,
      backgroundColorBtnR: rightButtonColor,
      radius: 20,
      header: showIcon
          ? Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Icon(icon, color: iconColor, size: 70),
            )
          : null,
      onCancel: () {
        Get.app.navigator.pop(false);
        submitActions?.cancel.onPressed?.call();
      },
      onConfirm: () {
        Get.app.navigator.pop(true);
        submitActions?.confirm.onPressed?.call();
      },
    );
  }

  static void showFailure(ServerException failure) => failure.showPopup();

  static Future warning<T>({
    required String title,
    required String message,
  }) {
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
    if (errorDetails != null) {
      Get.logger.log(
        errorDetails,
        logLevel: LogLevel.error,
      );
    }

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
    String message = "",
    bool showIcon = true,
    Widget? body,
    DialogType type = DialogType.info,
    PopupDialogInput? input,
    PopupDialogActions? submitActions,
  }) {
    final lightTheme = Theme.of(context).brightness == Brightness.light;
    final Color rightButtonColor;
    final Color leftButtonColor;
    final Color backgroundColor;
    final Color iconColor;
    final IconData icon;

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

    final cancelLabel = submitActions?.cancel.text ?? "Cancel";
    final confirmLabel = submitActions?.confirm.text ?? "OK";

    TextEditingController inputController = TextEditingController();
    ScrollController scrollController = ScrollController();
    final ValueNotifier<String?> inputErrorMessage = ValueNotifier(null);

    confirm() {
      if (input != null) {
        inputErrorMessage.value = input.validate?.call(inputController.text);
        if (inputErrorMessage.value == null || inputErrorMessage.value == "") {
          Get.app.navigator.pop(inputController.text);
          submitActions?.confirm.onPressed?.call();
        }
      } else {
        Get.app.navigator.pop(true);
        submitActions?.confirm.onPressed?.call();
      }
    }

    return DialogKh.alertDialogKh(
      context: context,
      isAutoClosed: false,
      disableBtn: false,
      header: showIcon ? Icon(icon, color: iconColor, size: 70) : null,
      onCancel: () {
        Get.app.navigator.pop(false);
        submitActions?.cancel.onPressed?.call();
      },
      onConfirm: confirm,
      labelColorBtnL: buttonTextColor,
      backgroundColorBtnL: leftButtonColor,
      descColor: descriptionColor,
      backgroundColor: backgroundColor,
      titleColor: titleColor,
      btnLabelL: cancelLabel,
      btnLabelR: confirmLabel,
      labelColorBtnR: buttonTextColor,
      backgroundColorBtnR: rightButtonColor,
      scrollController: scrollController,
      title: title,
      description: message,
      radius: 20,
      body: Column(
        children: [
          body ?? Text(message),
          if (input != null) const SizedBox(height: 12),
          if (input != null)
            TextField(
              controller: inputController,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
              onTap: () => Timer(
                const Duration(milliseconds: 500),
                () => scrollController.animateTo(
                  scrollController.position.maxScrollExtent,
                  curve: Curves.easeOut,
                  duration: const Duration(milliseconds: 100),
                ),
              ),
              onSubmitted: (String value) {
                confirm();
              },
              keyboardType: input.keyboardType,
              decoration: InputDecoration(
                labelText: input.label,
                labelStyle: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
                contentPadding: const EdgeInsets.all(10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
          const SizedBox(height: 6),
          ValueListenableBuilder(
            valueListenable: inputErrorMessage,
            builder: (context, value, child) {
              if (value != null && value.isNotEmpty) {
                return Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    value,
                    style: TextStyle(
                      color: Colors.red.shade800,
                      fontSize: 12,
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          )
        ],
      ),
    );
  }
}

class PopupDialogInput {
  const PopupDialogInput({
    this.label,
    this.validate,
    this.keyboardType,
  });

  final String? label;
  final String? Function(String)? validate;
  final TextInputType? keyboardType;
}

class PopupDialogAction {
  const PopupDialogAction({
    this.onPressed,
    required this.text,
  });

  final Function([String])? onPressed;
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
