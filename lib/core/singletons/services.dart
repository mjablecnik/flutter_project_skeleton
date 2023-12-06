import 'package:flutter/widgets.dart';
import 'package:flutter_project_skeleton/logic/services/http_api_service.dart';
import 'package:flutter_project_skeleton/logic/services/native_api_service.dart';
import 'package:flutter_project_skeleton/logic/services/storage_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@protected
class Services {
  late final Provider<NativeApiService> nativeApiService;
  late final Provider<HttpApiService> httpApiService;
  late final Provider<StorageService> storageService;

  static final Services get = Services._initialize();

  Services._initialize() {
    nativeApiService = Provider(NativeApiService.new);
    httpApiService = Provider(HttpApiService.new);
    storageService = Provider(StorageService.new);
  }
}
