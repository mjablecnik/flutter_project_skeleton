import 'package:flutter_project_skeleton/core/app/injector.dart';
import 'package:flutter_project_skeleton/core/app/logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:vader_popup/vader_popup.dart';

const popup = PopupDialog();

final injector = Injector.instance;

final logger = TalkerFlutter.init(
  observer: const CustomTalkerObserver(),
  settings: TalkerSettings(
    useHistory: false,
    useConsoleLogs: true,
    enabled: true,
  ),
);

class StoreKeys {
  static const deviceId = 'deviceId';
  static const loggedUser = 'loggedUser';
}

enum StorageKey { deviceId, loggedUser }

class Constants {
  static const methodChannel = 'flutter.app.channel';
}

class Routes {
  static const logo = '/';
  static const login = '/login';
  static const info = '/info';
  static const home = '/main-menu';
  static const dialogTester = '/dialog-tester';
}

enum Environment { mock, test, devel, preview, production }

enum DialogType { info, error, warning, success }
