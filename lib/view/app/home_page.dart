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
        body: const CatList(),
      ),
    );
  }
}
