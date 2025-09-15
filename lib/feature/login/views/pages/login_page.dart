import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/utils/route/app_routes.dart';
import 'package:chat_app/core/views/widgets/button.dart';
import 'package:chat_app/core/views/widgets/textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
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
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          SizedBox(height: size.height * 0.03),
          // email textfield
          Textfield(hint: 'Email', controller: _emailController),
          SizedBox(height: size.height * 0.015),
          // password textfield
          Textfield(hint: 'Password', isSecure: true, controller: _passwordController),
          SizedBox(height: size.height * 0.035),
          // login button
          Button(text: "Login", onTap: () {}),
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
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
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
