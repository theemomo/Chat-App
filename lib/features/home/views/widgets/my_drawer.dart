import 'package:chat_app/core/utils/route/app_routes.dart';
import 'package:chat_app/features/home/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: DrawerHeader(
              padding: const EdgeInsetsGeometry.all(0),
              child: Icon(
                Icons.message,
                color: Theme.of(context).colorScheme.primary,
                size: orientation == Orientation.portrait? MediaQuery.of(context).size.width * 0.2 : MediaQuery.of(context).size.height * 0.15,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListTile(
              title: Text("H O M E"),
              leading: Icon(Icons.home, color: Theme.of(context).colorScheme.primary),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListTile(
              title: Text("S E T T I N G S"),
              leading: Icon(Icons.settings, color: Theme.of(context).colorScheme.primary),
              onTap: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes.settingsRoute)
                    .then((value) => BlocProvider.of<HomeCubit>(context).getUsers());
              },
            ),
          ),
          const Spacer(),
          Builder(
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: ListTile(
                  title: Text("L O G O U T"),
                  leading: Icon(Icons.logout, color: Theme.of(context).colorScheme.primary),
                  onTap: () {
                    BlocProvider.of<HomeCubit>(context).logout();
                    Navigator.of(
                      context,
                    ).pushNamedAndRemoveUntil(AppRoutes.loginRoute, (route) => false);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
