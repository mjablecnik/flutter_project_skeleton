import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_skeleton/logic/cubits/cat_list_cubit.dart';
import 'package:flutter_project_skeleton/data/entities/cat.dart';
import 'package:flutter_project_skeleton/core/singletons/getter.dart';
import 'package:flutter_project_skeleton/view/layouts/default_layout.dart';
import 'package:flutter_project_skeleton/view/popups/default.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key});

  @override
  State<MainMenuPage> createState() => _HomePageState();
}

class _HomePageState extends State<MainMenuPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (Navigator.of(context).canPop()) {
          return Future.value(true);
        } else {
          return Popup.showCloseDialog();
        }
      },
      child: DefaultLayout(
        title: Get.cached.appName,
        body: BlocBuilder<CatListCubit, List<Cat>?>(
          builder: (context, tiles) {
            if (tiles == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView(
                children: [
                  for (var tile in tiles) ListTile(title: Text(tile.id)),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
