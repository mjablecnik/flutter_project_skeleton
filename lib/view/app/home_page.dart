import 'package:flutter/material.dart';
import 'package:flutter_project_skeleton/core/app/injector.dart';
import 'package:flutter_project_skeleton/view/features/product_list/product_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.injector});

  final Injector injector;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ProductListPage(injector: widget.injector);
  }
}
