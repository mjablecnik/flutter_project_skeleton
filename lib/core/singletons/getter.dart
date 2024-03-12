import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:flutter_project_skeleton/settings.dart';
import 'package:flutter_project_skeleton/core/app/global.dart';
import 'package:flutter_project_skeleton/core/singletons/cached_data.dart';
import 'package:flutter_project_skeleton/core/singletons/http_client.dart';
import 'package:flutter_project_skeleton/core/singletons/services.dart';
import 'package:flutter_project_skeleton/core/singletons/cubits.dart';
import 'package:vader_popup/popup_dialog.dart';

class Get {
  // Serve providers
  static final cubit = Cubits.get;

  // Serve services
  static final service = Services.get;

  // Serve simple preloaded data
  static final cached = CachedData.load;

  // Serve method channel
  static const methodChannel = MethodChannel(Constants.methodChannel);

  // Serve popup builder
  static final popup = PopupDialog(context: app.context);

  // Serve http client
  static final http = HttpClient.get;

  static final settings = Settings.get;
  
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

  static final App get = App._initialize();

  App._initialize() {
    navigatorKey = GlobalKey<NavigatorState>();
  }
}

