import 'dart:io'; // for InternetAddress.lookup

import 'package:chat_app/core/utils/app_constants.dart';
import 'package:chat_app/core/utils/route/app_router.dart';
import 'package:chat_app/core/utils/route/app_routes.dart';
import 'package:chat_app/core/view_models/auth_cubit/auth_cubit.dart';
import 'package:chat_app/core/view_models/theme_mode/theme_mode_cubit.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  bool hasInternet = await _pingGoogle();

  if (!hasInternet) {
    runApp(const NoInternetApp());
  } else {
    runApp(BlocProvider(create: (context) => ThemeModeCubit(), child: const MyApp()));
  }
}

/// Function to check real internet connection by pinging google.com
Future<bool> _pingGoogle() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
    return false;
  } on SocketException catch (_) {
    return false;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) {
            final cubit = AuthCubit();
            cubit.checkAuthStatus();
            return cubit;
          },
        ),
        BlocProvider<ThemeModeCubit>(create: (context) => ThemeModeCubit()),
      ],
      child: Builder(
        builder: (context) {
          return BlocBuilder<AuthCubit, AuthState>(
            buildWhen: (previous, current) => current is AuthSuccess || current is AuthInitial,
            builder: (context, state) {
              return BlocBuilder<ThemeModeCubit, ThemeData>(
                builder: (context, theme) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: AppConstants.appName,
                    theme: theme,
                    onGenerateRoute: AppRouter().onGenerateRoute,
                    initialRoute: state is AuthSuccess ? AppRoutes.homeRoute : AppRoutes.loginRoute,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class NoInternetApp extends StatelessWidget {
  const NoInternetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                backgroundColor: Colors.white,
                title: const Text("No Internet Connection"),
                content: const Text("The app will now close."),
                actions: [
                  TextButton(
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    child: const Text("OK"),
                  ),
                ],
              ),
              // barrierColor: Colors.white
            );
          });
          return const Scaffold(backgroundColor: Colors.white);
        },
      ),
    );
  }
}
