import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/utils/route/app_routes.dart';
import 'package:chat_app/core/views/widgets/button.dart';
import 'package:chat_app/core/views/widgets/textfield.dart';
import 'package:chat_app/feature/login/login_cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // logo
          Center(
            child: CachedNetworkImage(
              imageUrl: "https://cdn-icons-png.flaticon.com/512/5229/5229304.png",
              width: size.width * 0.3,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),

          SizedBox(height: size.height * 0.03),
          // welcome back message
          Text(
            "Welcome back, you've been missed!",
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          SizedBox(height: size.height * 0.03),
          // email textfield
          Textfield(hint: 'Email', controller: _emailController),
          SizedBox(height: size.height * 0.015),
          // password textfield
          Textfield(hint: 'Password', isSecure: true, controller: _passwordController),
          SizedBox(height: size.height * 0.035),

          // login button
          BlocConsumer<LoginCubit, LoginState>(
            listenWhen: (previous, current) =>
                current is LoginSuccessfully || current is LoginFailure,
            listener: (context, state) {
              if (state is LoginSuccessfully) {
                Navigator.pushNamedAndRemoveUntil(context, AppRoutes.homeRoute,(route) => false);
              } else if (state is LoginFailure) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            buildWhen: (previous, current) =>
                current is LoginLoading || current is LoginSuccessfully,
            builder: (context, state) {
              if (state is LoginLoading) {
                return const CircularProgressIndicator.adaptive();
              } else if (state is LoginSuccessfully) {
                return Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRoutes.homeRoute,
                        (route) => false,
                      );
                    },
                    child: const Text("Login Successful, proceed to home"),
                  ),
                );
              }
              return Button(
                text: "Login",
                onTap: () {
                  debugPrint("login pressed");
                  debugPrint(_emailController.text);
                  debugPrint(_passwordController.text);
                  if (_passwordController.text.isNotEmpty && _emailController.text.isNotEmpty) {
                    BlocProvider.of<LoginCubit>(
                      context,
                    ).login(_emailController.text, _passwordController.text);
                  }
                },
              );
            },
          ),
          SizedBox(height: size.height * 0.02),
          // register now
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.registerRoute);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "New a member? ",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.primary),
                ),
                Text(
                  "Register Now",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
