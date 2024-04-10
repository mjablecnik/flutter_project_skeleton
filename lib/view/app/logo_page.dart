import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_project_skeleton/core/app/global.dart';
import 'package:flutter_project_skeleton/logic/cubits/auth_cubit.dart';

class LogoPage extends StatefulWidget {
  const LogoPage({super.key});

  @override
  State<LogoPage> createState() => _LogoPageState();
}

class _LogoPageState extends State<LogoPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () async {
      final navigator = Navigator.of(context);
      final user = await injector.get<AuthCubit>().getLoggedUser();
      if (user == null) {
        navigator.pushReplacementNamed(Routes.login);
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
