import 'package:flutter/material.dart';
import 'package:flutter_project_skeleton/core/app/global.dart';
import 'package:flutter_project_skeleton/core/i18n/translations.g.dart';
import 'package:flutter_project_skeleton/logic/cubits/auth_cubit.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 280,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.zero),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(context.t.menu.loggedUser),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    injector.get<AuthCubit>().loggedUser?.fullName ?? "<unknown>",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Wrap(
                  spacing: 12,
                  children: [
                    Text(context.t.menu.role),
                    const Text(
                      "User",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(context.t.menu.settings),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(Routes.dialogTester);
            },
          ),
          ListTile(
            title: Text(context.t.menu.about),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(Routes.info);
            },
          ),
          ListTile(
            title: Text(context.t.menu.logout),
            onTap: () {
              Navigator.pop(context);
              injector.get<AuthCubit>().logout();
              Navigator.of(context).pushReplacementNamed(Routes.login);
            },
          ),
        ],
      ),
    );
  }
}
