import 'package:chat_app/core/utils/app_constants.dart';
import 'package:chat_app/core/utils/route/app_router.dart';
import 'package:chat_app/core/utils/route/app_routes.dart';
import 'package:chat_app/core/view_models/auth_cubit/auth_cubit.dart';
import 'package:chat_app/core/view_models/theme_mode/theme_mode_cubit.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(BlocProvider(create: (context) => ThemeModeCubit(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
        BlocProvider<ThemeModeCubit>(
          create: (context) => ThemeModeCubit(), // add other cubits here if needed
        ),
        // Add more BlocProviders here if necessary
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
