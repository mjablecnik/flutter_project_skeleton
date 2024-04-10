import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_skeleton/data/entities/product.dart';
import 'package:flutter_project_skeleton/logic/services/rest_api_service.dart';

class ProductListCubit extends Cubit<List<Product>?> {
  ProductListCubit({required RestApiService restApiService}) : super(null) {
    _restApiService = restApiService;
    init();
  }

  late final RestApiService _restApiService;

  update(List<Product>? state) {
    emit(state);
  }

  init() => reload();

  Future<void> reload() async {
    try {
      update(await _restApiService.getProducts());
    } catch (e) {
      update(null);
    }
  }
}
