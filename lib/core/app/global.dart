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
