import 'package:chat_app/core/view_models/theme_mode/theme_mode_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("S E T T I N G S"), centerTitle: true),
      body: Container(
  decoration: BoxDecoration(
    color: Theme.of(context).colorScheme.secondary,
    borderRadius: BorderRadius.circular(15),
  ),
  padding: const EdgeInsets.all(20),
  margin: const EdgeInsets.all(10),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text("Dark Mode", style: Theme.of(context).textTheme.titleLarge),
      BlocBuilder<ThemeModeCubit, ThemeData>(
        builder: (context, theme) {
          final isDark = theme.brightness == Brightness.dark;
          return CupertinoSwitch(
            value: isDark,
            onChanged: (_) => context.read<ThemeModeCubit>().toggleTheme(),
          );
        },
      ),
    ],
  ),
),

    );
  }
}
