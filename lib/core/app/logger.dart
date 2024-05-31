import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CustomTalkerObserver extends TalkerObserver {
  const CustomTalkerObserver();

  @override
  Future<void> onError(TalkerError err) async {
    /// Send data to your error tracking system like Sentry or backend
    super.onError(err);
    await Sentry.captureMessage(err.message);
  }

  @override
  Future<void> onException(TalkerException err) async {
    /// Send Exception to your error tracking system like Sentry or backend
    super.onException(err);
    await Sentry.captureException(err.exception, stackTrace: err.stackTrace);
  }

  @override
  Future<void> onLog(TalkerData log) async {
    /// Send log message to Grafana or backend
    super.onLog(log);
    await Sentry.captureMessage(log.message);
  }
}