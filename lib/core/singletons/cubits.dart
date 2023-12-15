import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_skeleton/logic/cubits/cat_list_cubit.dart';
import 'package:flutter_project_skeleton/logic/cubits/user_cubit.dart';

@protected
class Cubits {
  late final UserCubit user;
  late final CatListCubit cats;

  static final Cubits get = Cubits._initialize();

  List<Cubit> get list => [user, cats];

  Cubits._initialize() {
    user = UserCubit();

    cats = CatListCubit();
  }
}
