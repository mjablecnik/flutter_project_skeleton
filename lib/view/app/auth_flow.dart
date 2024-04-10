import 'package:flutter/material.dart';
import 'package:flutter_project_skeleton/core/app/exceptions.dart';
import 'package:flutter_project_skeleton/core/app/global.dart';
import 'package:flutter_project_skeleton/data/entities/user.dart';
import 'package:flutter_project_skeleton/logic/services/rest_api_service.dart';
import 'package:flutter_project_skeleton/logic/services/storage_service.dart';

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
    assert(result != null, 'No AuthFlow found in context');
    return result!;
  }

  login({
    required String userName,
    required String password,
    Function(User)? onSuccess,
    Function(ServerException)? onFailure,
  }) async {
    try {
      final restApiService = injector.get<RestApiService>();
      restApiService.setBasicAuth(userName, password);
      user.value = await restApiService.getUser(userName);
      injector.get<StorageService>().saveLoggedUser(user.value!);
      onSuccess?.call(user.value!);
    } on ServerException catch (e) {
      onFailure?.call(e);
    }
  }

  Future<User?> getLoggedUser() async {
    final storageService = injector.get<StorageService>();
    user.value ??= await storageService.getLoggedUser();
    return user.value;
  }

  bool logout() {
    user.value = null;
    final storageService = injector.get<StorageService>();
    final restApiService = injector.get<RestApiService>();
    storageService.saveLoggedUser(null);
    return restApiService.removeBasicAuth();
  }

  @override
  bool updateShouldNotify(AuthFlow oldWidget) {
    return true;
  }
}
