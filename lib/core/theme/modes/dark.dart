import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' as mt;

get dark {
  return mt.ThemeData(
    brightness: Brightness.dark,
    // extensions: const [
    //   AppTheme(
    //     backgroundColor: AppColors.black,
    //     appBarColor: AppColors.green,
    //     appBarText: TextStyle(),
    //     errorPage: ErrorPageTheme(
    //       titleText: TextStyle(
    //         fontSize: 30,
    //         fontWeight: mt.FontWeight.w600,
    //       ),
    //       descriptionText: TextStyle(fontSize: 20),
    //       detailText: TextStyle(fontSize: 15, fontWeight: mt.FontWeight.w400),
    //       detailTextButtonIcon: AppColors.green,
    //       detailTextButton: TextStyle(
    //         fontSize: 18,
    //         fontWeight: FontWeight.w400,
    //         color: AppColors.green,
    //         decorationColor: AppColors.green,
    //         decoration: TextDecoration.underline,
    //       ),
    //     ),
    //     loginPage: LoginPageTheme(
    //       titleText: TextStyle(),
    //       button: ButtonStyle(
    //         backgroundColor: AppColors.black,
    //         textColor: AppColors.whiteish,
    //         textStyle: TextStyle(),
    //       ),
    //     ),
    //   )
    // ],
  );
}
