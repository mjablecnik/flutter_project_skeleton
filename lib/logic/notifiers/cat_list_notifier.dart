import 'package:flutter_project_skeleton/data/entities/cat.dart';
import 'package:flutter_project_skeleton/logic/services/http_api_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_project_skeleton/core/singletons/getter.dart';

class CatListNotifier extends StateNotifier<List<Cat>?> {
  CatListNotifier(this.ref) : super(null) {
    _httpApiService = ref.read(Get.service.httpApiService);
    init();
  }

  final StateNotifierProviderRef ref;
  late final HttpApiService _httpApiService;

  update(List<Cat>? state) {
    this.state = state;
  }

  init() => load();

  Future<void> load() async {
    try {
      update(await _httpApiService.getCats());
    } catch (e) {
      update(null);
    }
  }
}
