import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_skeleton/logic/cubits/cat_list_cubit.dart';
import 'package:flutter_project_skeleton/logic/cubits/user_cubit.dart';

@protected
class Providers {
  late final BlocProvider<UserCubit> user;
  late final BlocProvider<CatListCubit> cats;

  static final Providers get = Providers._initialize();

  List<BlocProvider> get list => [user, cats];

  Providers._initialize() {
    user = BlocProvider<UserCubit>(create: (BuildContext context) => UserCubit());

    cats = BlocProvider<CatListCubit>(create: (BuildContext context) => CatListCubit());
  }
}
