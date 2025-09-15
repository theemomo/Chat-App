import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/views/widgets/button.dart';
import 'package:chat_app/core/views/widgets/textfield.dart';
import 'package:flutter/material.dart';

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
          Textfield(hint: 'Username', controller: _emailController),
          SizedBox(height: size.height * 0.015),
          // password textfield
          Textfield(hint: 'Password', isSecure: true, controller: _passwordController),
          SizedBox(height: size.height * 0.015),
          // password textfield
          Textfield(hint: 'Confirm Password', isSecure: true, controller: _confirmPasswordController),
          SizedBox(height: size.height * 0.035),
          // login button
          Button(text: "Register", onTap: () {}),
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
