import 'package:flutter_project_skeleton/logic/services/http_api_service.dart';
import 'package:flutter_project_skeleton/logic/services/storage_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:result_dart/result_dart.dart';
import 'package:flutter_project_skeleton/core/app/exceptions.dart';
import 'package:flutter_project_skeleton/data/entities/user.dart';
import 'package:flutter_project_skeleton/core/singletons/getter.dart';

class UserNotifier extends StateNotifier<User?> {
  UserNotifier(this.ref) : super(null) {
    _httpApiService = ref.read(Get.service.httpApiService);
    _storageService = ref.read(Get.service.storageService);
  }

  final StateNotifierProviderRef ref;
  late final HttpApiService _httpApiService;
  late final StorageService _storageService;

  update(User? user) {
    state = user;
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
