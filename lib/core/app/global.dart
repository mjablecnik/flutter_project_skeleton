import 'package:catcher_2/catcher_2.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_project_skeleton/core/app/injector.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:vader_popup/vader_popup.dart';

const PopupDialog _popup = PopupDialog();

final Injector _injector = Injector.instance;

final Talker _logger = TalkerFlutter.init(
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

enum StorageKey { deviceId, loggedUser, themeMode }

class Constants {
  static const methodChannel = 'flutter.app.channel';
}

class Routes {
  static const index = '/';
  static const auth = '/auth';
  static const about = '/about';
  static const home = '/home';
}

enum Environment { mock, test, devel, preview, production }

enum DialogType { info, error, warning, success }

class App extends InheritedWidget {
  App({
    super.key,
    Injector? injector,
    Talker? logger,
    PopupDialog? popup,
    required super.child,
  }) {
    this.injector = injector ?? _injector;
    getLogger = logger ?? _logger;
    getPopup = popup ?? _popup;
  }

  late final Injector injector;
  late final Talker getLogger;
  late final PopupDialog getPopup;

  static GlobalKey<NavigatorState>? navigatorKey = Catcher2.navigatorKey;

  NavigatorState? get navigator => navigatorKey?.currentState;

  BuildContext? get context => navigatorKey?.currentContext;

  static Talker get logger => _logger;

  static PopupDialog get popup => _popup;

  static App of(BuildContext context) {
    final App? result = context.dependOnInheritedWidgetOfExactType<App>();
    assert(result != null, 'No Injector found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(App oldWidget) {
    return false;
  }
}

extension BuildContextExtension on BuildContext {
  Injector get injector => App.of(this).injector;
  PopupDialog get popup => App.of(this).getPopup;
  Talker get logger => App.of(this).getLogger;
}
