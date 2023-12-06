import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:flutter_project_skeleton/core/app/flavors.dart';
import 'package:flutter_project_skeleton/core/app/global.dart';
import 'package:flutter_project_skeleton/core/singletons/cached_data.dart';
import 'package:flutter_project_skeleton/core/singletons/http_client.dart';
import 'package:flutter_project_skeleton/core/singletons/services.dart';
import 'package:flutter_project_skeleton/core/singletons/states.dart';

class Get {
  // Serve state notifier providers
  static final state = States.get;

  // Serve service providers
  static final service = Services.get;

  // Serve simple preloaded data
  static final cached = CachedData.load;

  // Serve method channel
  static const methodChannel = MethodChannel(Constants.methodChannel);

  // Serve http client
  static final http = HttpClient.get;

  // Serve logger object
  static final logger = TalkerFlutter.init(
    settings: TalkerSettings(
      useHistory: false,
    ),
  );

  // Serve object with global navigator and context
  static final app = App.get;
}

class App {
  late final GlobalKey<NavigatorState> navigatorKey;

  get navigator => navigatorKey.currentState;

  get context => navigatorKey.currentContext;

  Flavor get flavor => Flavors.get.currentFlavor;

  static final App get = App._initialize();

  App._initialize() {
    navigatorKey = GlobalKey<NavigatorState>();
  }
}

