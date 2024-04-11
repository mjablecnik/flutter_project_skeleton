import 'package:flutter/material.dart';
import 'package:flutter_project_skeleton/view/components/main_drawer.dart';
import 'package:flutter_project_skeleton/view/widgets/back_button_handler.dart';
import 'package:flutter_project_skeleton/view/widgets/connection_checker.dart';

class DefaultLayout extends StatelessWidget {
  const DefaultLayout({
    super.key,
    required this.title,
    required this.body,
    this.actions,
    this.drawer = const MainDrawer(),
    this.padding = EdgeInsets.zero,
    this.onBack,
  });

  final String title;
  final Widget body;
  final Widget? drawer;
  final EdgeInsetsGeometry padding;
  final List<Widget>? actions;
  final Function()? onBack;

  @override
  Widget build(BuildContext context) {
    return ConnectionChecker(
      child: BackButtonHandler(
        onBack: onBack,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(title),
            titleSpacing: 0,
            actions: actions,
          ),
          drawer: !Navigator.of(context).canPop() ? drawer : null,
          body: Padding(
            padding: padding,
            child: body,
          ),
        ),
      ),
    );
  }
}
