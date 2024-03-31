import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_skeleton/core/singletons/getter.dart';
import 'package:flutter_project_skeleton/data/entities/cat.dart';
import 'package:flutter_project_skeleton/logic/services/rest_api_service.dart';

class CatListCubit extends Cubit<List<Cat>?> {
  CatListCubit() : super(null) {
    _restApiService = Get.service.restApiService;
    init();
  }

  late final RestApiService _restApiService;

  update(List<Cat>? state) {
    emit(state);
  }

  init() => load();

  Future<void> load() async {
    try {
      update(await _restApiService.getCats());
    } catch (e) {
      update(null);
    }
  }
}
