import 'package:flutter/widgets.dart';
import 'package:flutter_project_skeleton/logic/notifiers/cat_list_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_project_skeleton/data/entities/cat.dart';
import 'package:flutter_project_skeleton/data/entities/user.dart';
import 'package:flutter_project_skeleton/logic/notifiers/user_notifier.dart';

@protected
class States {
  States({
    required this.user,
    required this.cats,
  });

  late final StateNotifierProvider<UserNotifier, User?> user;
  late final StateNotifierProvider<CatListNotifier, List<Cat>?> cats;

  static final States get = States._initialize();

  States._initialize() {

    user = StateNotifierProvider<UserNotifier, User?>((ref) {
      return UserNotifier(ref);
    });

    cats = StateNotifierProvider<CatListNotifier, List<Cat>?>((ref) {
      return CatListNotifier(ref);
    });
  }
}
