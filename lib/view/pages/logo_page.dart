import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_skeleton/core/app/global.dart';
import 'package:flutter_project_skeleton/data/entities/user.dart';
import 'package:flutter_project_skeleton/logic/cubits/user_cubit.dart';

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
      final User? user = await context.read<UserCubit>().getLoggedUser();
      navigator.pushReplacementNamed(user == null ? Routes.login : Routes.mainMenu);
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
