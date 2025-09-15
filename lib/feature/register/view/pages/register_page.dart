import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/utils/route/app_routes.dart';
import 'package:chat_app/core/views/widgets/button.dart';
import 'package:chat_app/core/views/widgets/textfield.dart';
import 'package:chat_app/feature/register/register_cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _confirmPasswordController = TextEditingController();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // logo
          Center(
            child: CachedNetworkImage(
              imageUrl: "https://cdn-icons-png.flaticon.com/512/5264/5264565.png",
              width: size.width * 0.5,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),

          SizedBox(height: size.height * 0.01),
          // welcome back message
          Text(
            "Let's create an account for you",
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          SizedBox(height: size.height * 0.03),
          // username textfield
          Textfield(hint: 'Email', controller: _emailController),
          SizedBox(height: size.height * 0.015),
          // password textfield
          Textfield(hint: 'Password', isSecure: true, controller: _passwordController),
          SizedBox(height: size.height * 0.015),
          // password textfield
          Textfield(
            hint: 'Confirm Password',
            isSecure: true,
            controller: _confirmPasswordController,
          ),
          SizedBox(height: size.height * 0.035),
          // login button
          // Button(text: "Register", onTap: () {}),
          BlocConsumer<RegisterCubit, RegisterState>(
            listenWhen: (previous, current) =>
                current is RegisterSuccessfully || current is RegisterFailure,
            listener: (context, state) {
              if (state is RegisterSuccessfully) {
                Navigator.pushNamedAndRemoveUntil(context, AppRoutes.homeRoute, (route) => false);
              } else if (state is RegisterFailure) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            buildWhen: (previous, current) =>
                current is RegisterLoading || current is RegisterSuccessfully,
            builder: (context, state) {
              if (state is RegisterLoading) {
                return const CircularProgressIndicator.adaptive();
              } else if (state is RegisterSuccessfully) {
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
                text: "Register",
                onTap: () {
                  debugPrint("Register pressed");
                  debugPrint(_emailController.text);
                  debugPrint(_passwordController.text);
                  if (_passwordController.text.isNotEmpty &&
                      _emailController.text.isNotEmpty &&
                      _confirmPasswordController.text.isNotEmpty) {
                    if (_passwordController.text == _confirmPasswordController.text) {
                      BlocProvider.of<RegisterCubit>(
                        context,
                      ).register(_emailController.text, _passwordController.text);
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Passwords do not match")));
                    }
                  }
                },
              );
            },
          ),
          SizedBox(height: size.height * 0.02),
          // login now
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.primary),
                ),
                Text(
                  "Login Now",
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
