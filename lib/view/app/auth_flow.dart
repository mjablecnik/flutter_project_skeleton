import 'package:flutter/material.dart';
import 'package:flutter_project_skeleton/core/app/exceptions.dart';
import 'package:flutter_project_skeleton/core/app/global.dart';
import 'package:flutter_project_skeleton/core/singletons/getter.dart';
import 'package:flutter_project_skeleton/data/entities/user.dart';

class AuthFlow extends InheritedWidget {
  const AuthFlow({
    super.key,
    required super.child,
    required this.user,
  });

  final ValueNotifier<User?> user;

  get loggedUser => user.value;

  static AuthFlow of(BuildContext context) {
    final AuthFlow? result = context.dependOnInheritedWidgetOfExactType<AuthFlow>();
    assert(result != null, 'No MyFlow found in context');
    return result!;
  }

  login(String userName, String password) async {
    try {
      final httpApiService = Get.service.httpApiService;
      httpApiService.setBasicAuth(userName, password);
      user.value = await httpApiService.getUser(userName);
      Get.service.storageService.saveLoggedUser(user.value);
      Get.app.navigator.pushReplacementNamed(Routes.home);
    } on ServerException catch (e) {
      e.showPopup();
    }
  }

  tryLogin() async {
    final User? loggedUser = await Get.service.storageService.getLoggedUser();
    if (user.value != null) user.value = loggedUser;
    if (loggedUser == null) {
      Get.app.navigator.pushReplacementNamed(Routes.login);
    } else {
      Get.app.navigator.pushReplacementNamed(Routes.home);
    }
  }

  bool logout() {
    user.value = null;
    Get.service.storageService.saveLoggedUser(null);
    return Get.service.httpApiService.removeBasicAuth();
  }

  @override
  bool updateShouldNotify(AuthFlow old) {
    return true;
  }
}
