import 'package:flutter/material.dart';
import 'package:flutter_project_skeleton/core/handlers/back_button_handler.dart';
import 'package:flutter_project_skeleton/core/handlers/connectivity_handler.dart';
import 'package:flutter_project_skeleton/core/theme/app.dart';
import 'package:flutter_project_skeleton/view/layouts/default/default_drawer.dart';

class DefaultLayout extends StatelessWidget {
  const DefaultLayout({
    super.key,
    required this.title,
    required this.body,
    this.actions,
    this.drawer = const DefaultDrawer(),
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
    return ConnectivityHandler(
      child: BackButtonHandler(
        onBack: onBack,
        child: Scaffold(
          backgroundColor: context.appTheme.layout.backgroundColor,
          appBar: AppBar(
            backgroundColor: context.appTheme.layout.appBarColor,
            title: Text(title, style: context.appTheme.layout.appBarText),
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
