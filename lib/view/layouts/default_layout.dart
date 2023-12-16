import 'package:flutter/material.dart';
import 'package:flutter_project_skeleton/view/components/main_drawer.dart';

class DefaultLayout extends StatelessWidget {
  const DefaultLayout({
    super.key,
    required this.title,
    required this.body,
    this.drawer = const MainDrawer(),
  });

  final String title;
  final Widget body;
  final Widget drawer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        titleSpacing: 0,
      ),
      drawer: !Navigator.of(context).canPop() ? drawer : null,
      body: body,
    );
  }
}
