import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_project_skeleton/core/app/global.dart';
import 'package:flutter_project_skeleton/logic/cubits/auth_cubit.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () async {
      final navigator = Navigator.of(context);
      final user = await context.injector.get<AuthCubit>().getLoggedUser();
      if (user == null) {
        navigator.pushReplacementNamed(Routes.auth);
      } else {
        navigator.pushReplacementNamed(Routes.home);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 200,
        height: 200,
        child: Image.asset("assets/icons/icon.png"),
      ),
    );
  }
}
