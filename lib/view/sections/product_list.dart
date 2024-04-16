import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_skeleton/core/app/global.dart';
import 'package:flutter_project_skeleton/data/entities/product.dart';
import 'package:flutter_project_skeleton/logic/cubits/product_list_cubit.dart';
import 'package:flutter_project_skeleton/view/widgets/loader.dart';
import 'package:flutter_project_skeleton/view/widgets/reloader.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductListCubit, List<Product>?>(
      bloc: injector.get<ProductListCubit>(),
      builder: (context, products) {
        if (products == null) {
          return const Loader();
        } else {
          return RefreshIndicator(
            onRefresh: injector.get<ProductListCubit>().reload,
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  for (var product in products) ListTile(title: Text(product.title)),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
