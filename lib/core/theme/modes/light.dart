import 'package:design_package_example/design_package_example.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' as mt;
import 'package:flutter/painting.dart';
import 'package:flutter_project_skeleton/core/theme/app.dart';
import 'package:flutter_project_skeleton/core/theme/modes/colors.dart';
import 'package:flutter_project_skeleton/core/theme/components.dart';
import 'package:flutter_project_skeleton/core/theme/pages.dart';

get light {
  return mt.ThemeData(
    brightness: Brightness.light,
    colorSchemeSeed: AppColors.green,
    inputDecorationTheme: const mt.InputDecorationTheme(
      labelStyle: TextStyle(color: AppColors.green),
      focusColor: AppColors.greenLight,
      focusedBorder: mt.UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.greenLight),
      ),
      activeIndicatorBorder: BorderSide(color: AppColors.red),
      fillColor: AppColors.red,
    ),
    extensions: [
      DesignPackageThemeExtension.light,
      const AppTheme(
        layout: LayoutTheme(
          backgroundColor: AppColors.whiteish,
          appBarColor: AppColors.greenLight,
          appBarText: TextStyle(fontSize: 26),
        ),
        errorPage: ErrorPageTheme(
          titleText: TextStyle(fontSize: 30, fontWeight: mt.FontWeight.w600),
          descriptionText: TextStyle(fontSize: 18),
          detailText: TextStyle(fontSize: 15, fontWeight: mt.FontWeight.w400),
          detailTextButtonIcon: AppColors.green,
          detailTextButton: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: AppColors.green,
            decorationColor: AppColors.green,
            decoration: TextDecoration.underline,
          ),
        ),
        loginPage: LoginPageTheme(
          titleText: TextStyle(
            fontSize: 30,
            fontWeight: mt.FontWeight.w600,
          ),
          button: ButtonComponentTheme(
            backgroundColor: AppColors.greenLight,
            textColor: AppColors.black,
            textStyle: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ),
    ],
  );
}