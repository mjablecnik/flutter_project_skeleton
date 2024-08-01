import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_project_skeleton/core/app/global.dart';
import 'package:flutter_project_skeleton/core/app/cached_data.dart';
import 'package:flutter_project_skeleton/core/i18n/translations.g.dart';
import 'package:flutter_project_skeleton/core/theme/app.dart';
import 'package:flutter_project_skeleton/logic/cubits/auth_cubit.dart';
import 'package:flutter_project_skeleton/view/layouts/default/default_layout.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  Future<void> submit() async {
    final isValid = _formKey.currentState?.saveAndValidate();
    if (isValid != true) return;

    final form = _formKey.currentState?.value;
    injector.get<AuthCubit>().tokenAuthLogin(
          userName: form!['name'],
          password: form['password'],
          onSuccess: (user) => Navigator.of(context).pushReplacementNamed(Routes.home),
          onFailure: (e) => e.showPopup(context),
        );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: injector.get<CachedData>().appName,
      drawer: null,
      actions: [
        PopupMenuButton(
          position: PopupMenuPosition.under,
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            PopupMenuItem(
              onTap: () => Navigator.of(context).pushNamed(Routes.about),
              child: Text(context.t.menu.about),
            ),
          ],
        ),
      ],
      body: KeyboardVisibilityBuilder(
        builder: (BuildContext context, bool isKeyboardVisible) {
          return ListView(
            padding: EdgeInsets.only(
              left: 50.0,
              right: 50.0,
              top: isKeyboardVisible ? 30 : 80,
              bottom: 50,
            ),
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              Text(
                context.t.login.title,
                style: context.appTheme.loginPage.titleText,
              ),
              const SizedBox(height: 20),
              FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    FormBuilderTextField(
                      name: 'name',
                      decoration: InputDecoration(labelText: context.t.login.name),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          errorText: context.t.login.error.required.name,
                        ),
                      ]),
                    ),
                    const SizedBox(height: 10),
                    FormBuilderTextField(
                      name: 'password',
                      decoration: InputDecoration(labelText: context.t.login.password),
                      obscureText: true,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          errorText: context.t.login.error.required.password,
                        ),
                      ]),
                    ),
                    const SizedBox(height: 100),
                    MaterialButton(
                      height: 50,
                      minWidth: 300,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      color: context.appTheme.loginPage.button.backgroundColor,
                      textColor: context.appTheme.loginPage.button.textColor,
                      onPressed: submit,
                      child: Text(
                        context.t.login.submit,
                        style: context.appTheme.loginPage.button.textStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
