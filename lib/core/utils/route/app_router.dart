import 'package:chat_app/core/utils/route/app_routes.dart';
import 'package:chat_app/feature/home/views/pages/home_page.dart';
import 'package:chat_app/feature/login/views/pages/login_page.dart';
import 'package:chat_app/feature/settings/views/page/settings_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.loginRoute:
        return CupertinoPageRoute(builder: (context) => const LoginPage());
      case AppRoutes.homeRoute:
        return CupertinoPageRoute(builder: (context) => const HomePage());
      case AppRoutes.settingsRoute:
        return CupertinoPageRoute(builder: (context) => const SettingsPage());
      default:
        return CupertinoPageRoute(
          builder: (context) => const Scaffold(body: Center(child: Text("Page Not Found"))),
        );
    }
  }
}