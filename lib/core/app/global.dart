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

class App {
  static GlobalKey<NavigatorState>? navigatorKey = Catcher2.navigatorKey;

  NavigatorState? get navigator => navigatorKey?.currentState;

  BuildContext? get context => navigatorKey?.currentContext;

  static Talker get logger => _logger;

  static PopupDialog get popup => _popup;
}

class InjectorProvider extends InheritedWidget {
  InjectorProvider({
    super.key,
    Injector? injector,
    required super.child,
  }) {
    this.injector = injector ?? _injector;
  }

  late final Injector injector;

  static InjectorProvider of(BuildContext context) {
    final InjectorProvider? result = context.dependOnInheritedWidgetOfExactType<InjectorProvider>();
    assert(result != null, 'No InjectorProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(InjectorProvider oldWidget) {
    return false;
  }
}

extension BuildContextExtension on BuildContext {
  Injector get injector => InjectorProvider.of(this).injector;
}
