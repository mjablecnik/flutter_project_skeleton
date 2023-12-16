import 'package:flutter/widgets.dart';
import 'package:flutter_project_skeleton/logic/cubits/cat_list_cubit.dart';

@protected
class Cubits {
  late final CatListCubit cats;

  static final Cubits get = Cubits._initialize();

  Cubits._initialize() {
    cats = CatListCubit();
  }
}
