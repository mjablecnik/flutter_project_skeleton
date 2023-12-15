import 'package:flutter_project_skeleton/core/app/global.dart';

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

class Settings {
  late final String apiUrl;
  late final String apiKey;
  late final Environment environment;
  late final Logs logs = const Logs();
  late final String? sentryDsn;

  static final Settings get = Settings._initialize();

  Settings._initialize() {
    const flavor = String.fromEnvironment("FLAVOR");

    switch (flavor) {
      case "prod" || "production":
        apiUrl = "";
        apiKey = "";
        environment = Environment.production;
        sentryDsn = null;
      case "preview":
        apiUrl = "";
        apiKey = "";
        environment = Environment.preview;
        sentryDsn = null;
      case "dev" || "devel" || "development":
        apiUrl = "";
        apiKey = "";
        environment = Environment.devel;
        sentryDsn = null;
      case "test":
        apiUrl = "";
        apiKey = "";
        environment = Environment.test;
        sentryDsn = null;
      default:
        apiUrl = "https://api.thecatapi.com";
        apiKey = "";
        environment = Environment.devel;
        sentryDsn = null;
    }
  }
}
