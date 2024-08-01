import 'package:flutter/material.dart';
import 'package:flutter_project_skeleton/core/app/cached_data.dart';
import 'package:flutter_project_skeleton/core/app/injector.dart';
import 'package:flutter_project_skeleton/view/layouts/default/default_layout.dart';

import 'product_list.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key, required this.injector});

  final Injector injector;

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: widget.injector.get<CachedData>().appName,
      body: ProductList(injector: widget.injector),
    );
  }
}
