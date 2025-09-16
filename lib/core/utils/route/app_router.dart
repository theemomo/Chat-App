import 'package:chat_app/core/utils/route/app_routes.dart';
import 'package:chat_app/features/home/home_cubit/home_cubit.dart';
import 'package:chat_app/features/home/views/pages/home_page.dart';
import 'package:chat_app/features/login/login_cubit/login_cubit.dart';
import 'package:chat_app/features/login/views/pages/login_page.dart';
import 'package:chat_app/features/register/register_cubit/register_cubit.dart';
import 'package:chat_app/features/register/view/pages/register_page.dart';
import 'package:chat_app/features/settings/views/page/settings_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.loginRoute:
        return CupertinoPageRoute(
          builder: (context) =>
              BlocProvider(create: (context) => LoginCubit(), child: const LoginPage()),
        );
      case AppRoutes.homeRoute:
        return CupertinoPageRoute(
          builder: (context) =>
              BlocProvider(create: (context) => HomeCubit(), child: const HomePage()),
        );
      case AppRoutes.registerRoute:
        return CupertinoPageRoute(
          builder: (context) =>
              BlocProvider(create: (context) => RegisterCubit(), child: const RegisterPage()),
        );
      case AppRoutes.settingsRoute:
        return CupertinoPageRoute(builder: (context) => const SettingsPage());
      default:
        return CupertinoPageRoute(
          builder: (context) => const Scaffold(body: Center(child: Text("Page Not Found"))),
        );
    }
  }
}
