import 'package:flutter_project_skeleton/core/app/global.dart';
import 'package:flutter_project_skeleton/settings.dart';

class Logs {
  final bool preventLargeResponses;
  final bool enableHttpLogs;
  final bool enableConsoleLogs;

  const Logs({
    this.preventLargeResponses = true,
    this.enableHttpLogs = true,
    this.enableConsoleLogs = true,
  });
}

class Flavor {
  const Flavor({
    required this.apiUrl,
    required this.apiKey,
    required this.environment,
    this.logs = const Logs(),
    this.sentryDsn,
  });

  final String apiUrl;
  final String apiKey;
  final Environment environment;
  final Logs logs;
  final String? sentryDsn;
}

class Flavors {
  Flavors._initialize() {
    _flavor = const String.fromEnvironment("FLAVOR");
    currentFlavor = _environment();
  }

  static final Flavors get = Flavors._initialize();

  late final String _flavor;
  late final Flavor currentFlavor;

  Flavor _environment() {
    switch (_flavor) {
      // case "prod" || "production":
      //   return const Flavor(
      //       apiUrl: "",
      //       apiKey: Settings.serverApiKey,
      //       environment: Environment.production,
      //       logs: Logs(enableConsoleLogs: false, enableHttpLogs: false),
      //       sentryDsn: ""
      //   );
      // case "preview":
      //   return const Flavor(
      //     apiUrl: "",
      //     apiKey: Settings.serverApiKey,
      //     environment: Environment.preview,
      //   );
      // case "dev" || "devel" || "development":
      //   return Flavor(
      //     apiUrl: "",
      //     apiKey: Settings.serverApiKey,
      //     environment: Environment.devel,
      //     sentryDsn: Settings.sentryDsn.isNotEmpty ? Settings.sentryDsn : null,
      //   );
      // case "test":
      //   return const Flavor(
      //     apiUrl: Settings.testApiUrl,
      //     apiKey: "TEST-API-KEY",
      //     environment: Environment.test,
      //   );
      default:
        return Flavor(
          apiUrl: "https://api.thecatapi.com",
          apiKey: Settings.serverApiKey,
          environment: Environment.devel,
          sentryDsn: Settings.sentryDsn.isNotEmpty ? Settings.sentryDsn : null,
        );
    }
  }
}
