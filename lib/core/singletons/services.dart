import 'package:flutter/widgets.dart';
import 'package:flutter_project_skeleton/logic/services/rest_api_service.dart';
import 'package:flutter_project_skeleton/logic/services/native_api_service.dart';
import 'package:flutter_project_skeleton/logic/services/storage_service.dart';

@protected
class Services {
  late final NativeApiService nativeApiService;
  late final RestApiService restApiService;
  late final StorageService storageService;

  static final Services get = Services._initialize();

  Services._initialize() {
    nativeApiService = const NativeApiService();
    restApiService = RestApiService();
    storageService = StorageService();
  }
}
