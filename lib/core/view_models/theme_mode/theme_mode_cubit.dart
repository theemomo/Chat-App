import 'package:chat_app/core/utils/themes/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class ThemeModeCubit extends Cubit<ThemeData> {
  ThemeModeCubit() : super(AppTheme.lightTheme); // default theme

  bool isDark = false;

  void toggleTheme() {
    isDark = !isDark;
    emit(isDark ? AppTheme.darkTheme : AppTheme.lightTheme);
  }
}
