import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_skeleton/core/app/global.dart';
import 'package:flutter_project_skeleton/data/entities/cat.dart';
import 'package:flutter_project_skeleton/logic/cubits/cat_list_cubit.dart';
import 'package:flutter_project_skeleton/view/widgets/loader.dart';
import 'package:flutter_project_skeleton/view/widgets/reloader.dart';

class CatList extends StatefulWidget {
  const CatList({super.key});

  @override
  State<CatList> createState() => _CatListState();
}

class _CatListState extends State<CatList> {
  final scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatListCubit, List<Cat>?>(
      bloc: injector.get<CatListCubit>(),
      builder: (context, tiles) {
        if (tiles == null) {
          return const Loader();
        } else {
          return SingleChildScrollView(
            controller: scrollController,
            child: Reloader(
              scrollController: scrollController,
              onReload: injector.get<CatListCubit>().reload,
              child: Column(
                children: [
                  for (var tile in tiles) ListTile(title: Text(tile.id)),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
