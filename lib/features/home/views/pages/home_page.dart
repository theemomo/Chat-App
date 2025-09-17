import 'package:chat_app/core/utils/route/app_routes.dart';
import 'package:chat_app/features/home/home_cubit/home_cubit.dart';
import 'package:chat_app/features/home/views/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(),
      body: BlocConsumer<HomeCubit, HomeState>(
        listenWhen: (previous, current) => current is HomeFailure,
        listener: (context, state) {
          if (state is HomeFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        buildWhen: (previous, current) => current is HomeLoading || current is HomeLoaded,
        builder: (context, state) {
          if (state is HomeLoaded) {
            return StreamBuilder(
              stream: state.stream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return (Text(snapshot.error.toString()));
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No users found.'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading...");
                }

                final users = snapshot.data; // List<UserModel>

                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(
                          context,
                        ).pushNamed(AppRoutes.chatRoute, arguments: users[index]);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(12),
                        ),

                        child: ListTile(
                          title: Text(users[index].email ?? "No Email"),
                          leading: Icon(Icons.person),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is HomeLoading) {
            return Center(child: const CircularProgressIndicator.adaptive());
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
