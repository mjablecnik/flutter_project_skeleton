import 'package:flutter/material.dart';
import 'package:flutter_project_skeleton/core/app/cached_data.dart';
import 'package:flutter_project_skeleton/core/app/injector.dart';
import 'package:flutter_project_skeleton/view/layouts/default_layout.dart';
import 'package:flutter_project_skeleton/view/sections/product_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.injector});

  final Injector injector;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: widget.injector.get<CachedData>().appName,
      body: ProductList(injector: widget.injector),
    );
  }
}
