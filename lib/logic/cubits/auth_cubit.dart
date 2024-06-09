import 'package:bloc/bloc.dart';
import 'package:flutter_project_skeleton/core/app/exceptions.dart';
import 'package:flutter_project_skeleton/data/entities/user.dart';
import 'package:flutter_project_skeleton/logic/services/rest_api_service.dart';
import 'package:flutter_project_skeleton/logic/services/storage_service.dart';

class AuthCubit extends Cubit<User?> {
  AuthCubit({
    required RestApiService restApiService,
    required StorageService storageService,
  })  : _restApiService = restApiService,
        _storageService = storageService,
        super(null);

  late final RestApiService _restApiService;
  late final StorageService _storageService;

  update(User? state) {
    emit(state);
  }

  get loggedUser => state;

  basicAuthLogin({
    required String userName,
    required String password,
    Function(User)? onSuccess,
    Function(ServerException)? onFailure,
  }) async {
    try {
      _restApiService.setBasicAuth(userName, password);
      update(await _restApiService.getUser(userName));
      _storageService.saveLoggedUser(state);
      onSuccess?.call(state!);
    } on ServerException catch (e) {
      onFailure?.call(e);
    }
  }

  tokenAuthLogin({
    required String userName,
    required String password,
    Function(User)? onSuccess,
    Function(ServerException)? onFailure,
  }) async {
    try {
      final User user = await _restApiService.login('emilys', 'emilyspass');
      if (user.token != null) _restApiService.setAuthToken(user.token!);
      update(user);
      _storageService.saveLoggedUser(user);
      onSuccess?.call(user);
    } on ServerException catch (e) {
      onFailure?.call(e);
    }
  }

  Future<User?> getLoggedUser() async {
    try {
      final User? user = await _storageService.getLoggedUser();
      if (user?.token != null) {
        _restApiService.setAuthToken(user!.token!);
        update(await _restApiService.getLoggedUser());
        return state;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  bool logout() {
    update(null);
    _storageService.saveLoggedUser(null);
    return _restApiService.removeAuth();
  }
}
