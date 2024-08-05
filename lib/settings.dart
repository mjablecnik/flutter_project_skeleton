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
  final Logs logs = const Logs();

  Settings() {
    const flavor = String.fromEnvironment("FLAVOR");

    switch (flavor) {
      case "prod" || "production":
        apiUrl = "";
        apiKey = "";
        environment = Environment.production;
      case "preview":
        apiUrl = "";
        apiKey = "";
        environment = Environment.preview;
      case "dev" || "devel" || "development":
        apiUrl = "";
        apiKey = "";
        environment = Environment.devel;
      case "test":
        apiUrl = "";
        apiKey = "";
        environment = Environment.test;
      default:
        apiUrl = "https://dummyjson.com";
        apiKey = "";
        environment = Environment.devel;
    }
  }
}
