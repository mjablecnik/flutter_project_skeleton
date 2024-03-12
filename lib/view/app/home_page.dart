import 'package:flutter/material.dart';
import 'package:flutter_project_skeleton/core/singletons/getter.dart';
import 'package:flutter_project_skeleton/view/layouts/default_layout.dart';
import 'package:flutter_project_skeleton/view/popups/default.dart';
import 'package:flutter_project_skeleton/view/sections/cat_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) return;
        if (Get.app.navigator.canPop()) {
          Get.app.navigator.pop(true);
        } else {
          final bool shouldPop = await Popup.showCloseDialog();
          if (shouldPop) {
            Get.app.navigator.pop();
          }
        }
      },
      child: DefaultLayout(
        title: Get.cached.appName,
        body: const CatList(),
      ),
    );
  }
}
