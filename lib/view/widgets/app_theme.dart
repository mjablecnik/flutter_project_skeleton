import 'package:flutter/widgets.dart';
import 'package:flutter_project_skeleton/core/app/global.dart';
import 'package:flutter_project_skeleton/core/theme/theme.dart';
import 'package:flutter_project_skeleton/logic/services/storage_service.dart';

class ThemeProvider extends InheritedWidget {
  ThemeProvider({
    super.key,
    required super.child,
  }) {
    theme = ValueNotifier(_defaultTheme);
    load();
  }

  final Theme _defaultTheme = Theme.standard();
  late final ValueNotifier<Theme> theme;

  load() async {
    theme.value = (await injector.get<StorageService>().getTheme()) ?? _defaultTheme;
  }

  update(Theme state) {
    theme.value = state;
    injector.get<StorageService>().saveTheme(state);
  }

  static ThemeProvider of(BuildContext context) {
    final ThemeProvider? result = context.dependOnInheritedWidgetOfExactType<ThemeProvider>();
    assert(result != null, 'No AppTheme found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ThemeProvider oldWidget) {
    return true;
  }
}
