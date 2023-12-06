import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_project_skeleton/data/entities/cat.dart';
import 'package:flutter_project_skeleton/core/singletons/getter.dart';
import 'package:flutter_project_skeleton/view/layouts/default_layout.dart';
import 'package:flutter_project_skeleton/view/popups/default.dart';

class MainMenuPage extends ConsumerStatefulWidget {
  const MainMenuPage({super.key});

  @override
  ConsumerState<MainMenuPage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<MainMenuPage> {
  @override
  Widget build(BuildContext context) {
    List<Cat>? tiles = ref.watch(Get.state.cats);

    if (tiles == null) {
      return DefaultLayout(
        title: Get.cached.appName,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

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
        body: ListView(
          children: [
            for (var tile in tiles) ListTile(title: Text(tile.id)),
          ],
        ),
      ),
    );
  }
}
