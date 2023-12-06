import 'package:flutter_project_skeleton/core/app/global.dart';
import 'package:flutter_project_skeleton/core/i18n/translations.g.dart';
import 'package:flutter_project_skeleton/core/singletons/getter.dart';
import 'package:flutter_project_skeleton/view/popups/default.dart';

class ServerException implements Exception {
  final String? message;

  ServerException({this.message});

  @override
  String toString() {
    return 'ServerException: $message';
  }

  void showPopup() {
    final error = t.errors[runtimeType.toString()]!;
    Popup.dialog(
      Get.app.context,
      title: error.title,
      message: error.message,
      type: DialogType.values.byName(error.type),
    );
  }
}

class ParseDataException extends ServerException {
  final String? message;

  ParseDataException({this.message});
}

class AccessDeniedException extends ServerException {}

class UnknownTerminalException extends ServerException {}

class InternetConnectionException extends ServerException {}
