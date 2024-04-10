import 'package:auto_injector/auto_injector.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_project_skeleton/core/app/global.dart';
import 'package:flutter_project_skeleton/core/clients/http_client.dart';
import 'package:flutter_project_skeleton/core/clients/secure_storage.dart';
import 'package:flutter_project_skeleton/core/app/cached_data.dart';
import 'package:flutter_project_skeleton/logic/cubits/auth_cubit.dart';
import 'package:flutter_project_skeleton/logic/cubits/product_list_cubit.dart';
import 'package:flutter_project_skeleton/logic/services/native_api_service.dart';
import 'package:flutter_project_skeleton/logic/services/rest_api_service.dart';
import 'package:flutter_project_skeleton/logic/services/storage_service.dart';
import 'package:flutter_project_skeleton/settings.dart';

@protected
class Injector {
  static final Injector instance = Injector._initialize();

  final _injector = AutoInjector();

  Injector._initialize() {
    _injector.addInstance(const MethodChannel(Constants.methodChannel));
    _injector.addSingleton(SecureStorage.new);

    _injector.addSingleton(CachedData.new);
    _injector.addSingleton(Settings.new);

    _injector.addSingleton(HttpClient.new);

    _injector.addSingleton(NativeApiService.new);
    _injector.addSingleton(RestApiService.new);
    _injector.addSingleton(StorageService.new);

    _injector.addLazySingleton(AuthCubit.new);
    _injector.addLazySingleton(ProductListCubit.new);

    _injector.commit();
  }

  T get<T>({ParamTransform? transform, String? key}) => _injector.get<T>(transform: transform, key: key);
}
