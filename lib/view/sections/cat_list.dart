import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_skeleton/core/singletons/getter.dart';
import 'package:flutter_project_skeleton/data/entities/cat.dart';
import 'package:flutter_project_skeleton/logic/cubits/cat_list_cubit.dart';
import 'package:flutter_project_skeleton/view/widgets/circular_loader.dart';

class CatList extends StatelessWidget {
  const CatList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatListCubit, List<Cat>?>(
      bloc: Get.cubit.cats,
      builder: (context, tiles) {
        if (tiles == null) {
          return const CircularLoader();
        } else {
          return ListView(
            children: [
              for (var tile in tiles) ListTile(title: Text(tile.id)),
            ],
          );
        }
      },
    );
  }
}
