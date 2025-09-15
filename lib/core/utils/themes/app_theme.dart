import 'package:chat_app/core/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    colorScheme: ColorScheme.light(
      surface: Colors.grey.shade300,
      primary: AppColors.lightPrimary,
      secondary: AppColors.lightSecondary,
      tertiary: Colors.white,
      inversePrimary: Colors.grey.shade900

    )
  );

  static ThemeData get darkTheme => ThemeData();
}
