import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_project_skeleton/logic/cubits/user_cubit.dart';
import 'package:flutter_project_skeleton/core/app/global.dart';
import 'package:flutter_project_skeleton/core/singletons/getter.dart';
import 'package:flutter_project_skeleton/core/i18n/translations.g.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_project_skeleton/view/popups/default.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  Future<void> submit() async {
    final userCubit = context.read<UserCubit>();
    final isValid = _formKey.currentState?.saveAndValidate();
    if (isValid != true) return;

    final form = _formKey.currentState?.value;
    (await userCubit.login(form!['name'], form['password'])).fold(
      (user) => Navigator.of(context).pushReplacementNamed(Routes.mainMenu),
      (error) => error.showPopup(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Popup.showCloseDialog,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(Get.cached.appName),
          actions: [
            PopupMenuButton(
              position: PopupMenuPosition.under,
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                PopupMenuItem(
                  onTap: () => Navigator.of(context).pushNamed(Routes.info),
                  child: Text(context.t.menu.about),
                ),
              ],
            ),
          ],
        ),
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
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: [
                      FormBuilderTextField(
                        name: 'name',
                        decoration: InputDecoration(labelText: context.t.login.name),
                        keyboardType: TextInputType.number,
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
                        keyboardType: TextInputType.number,
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
                        color: Theme.of(context).colorScheme.primary,
                        textColor: Theme.of(context).colorScheme.background,
                        onPressed: submit,
                        child: Text(context.t.login.submit),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
