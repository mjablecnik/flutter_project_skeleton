import 'package:bloc/bloc.dart';
import 'package:flutter_project_skeleton/core/app/exceptions.dart';
import 'package:flutter_project_skeleton/core/singletons/getter.dart';
import 'package:flutter_project_skeleton/data/entities/user.dart';
import 'package:flutter_project_skeleton/logic/services/http_api_service.dart';
import 'package:flutter_project_skeleton/logic/services/storage_service.dart';
import 'package:result_dart/result_dart.dart';

class UserCubit extends Cubit<User?> {
  UserCubit() : super(null) {
    _httpApiService = Get.service.httpApiService;
    _storageService = Get.service.storageService;
  }

  late final HttpApiService _httpApiService;
  late final StorageService _storageService;

  update(User? user) {
    emit(user);
  }

  Future<User?> getLoggedUser() async {
    final User? user = await _storageService.getLoggedUser();
    if (user != null) update(user);
    return user;
  }

  Future<Result<User?, ServerException>> login(String userName, String password) async {
    try {
      _httpApiService.setBasicAuth(userName, password);
      final user = await _httpApiService.getUser(userName);
      update(user);
      _storageService.saveLoggedUser(user);
      return Success(user);
    } on ServerException catch (e) {
      return Failure(e);
    }
  }

  bool logout() {
    update(null);
    _storageService.saveLoggedUser(null);
    return _httpApiService.removeBasicAuth();
  }
}
