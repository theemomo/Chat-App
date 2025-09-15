import 'package:chat_app/core/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
    final VoidCallback onTap;
  const Button({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25.0), // inside
        margin: const EdgeInsets.symmetric(horizontal: 25.0), // outside
        decoration: BoxDecoration(color: AppColors.lightSecondary, borderRadius: BorderRadius.circular(6)),
        child: Center(child: Text(text)),
      ),
    );
  }
}
