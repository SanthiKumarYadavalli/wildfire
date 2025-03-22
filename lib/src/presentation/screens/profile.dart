import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wildfire/src/presentation/widgets/name_edit.dart';
import 'package:wildfire/src/presentation/widgets/profile_pic_edit.dart';
import 'package:wildfire/src/providers/user_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: user.when(
        data: (user) => Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ProfilePicEdit(user: user!),
              const SizedBox(height: 30),
              NameEdit(user: user),
              ListTile(
                title: const Text('Username'),
                subtitle: Text(user.username),
                titleTextStyle: TextStyle(color: Colors.black, fontSize: 15),
                subtitleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
                leading: Icon(Icons.tag),
              ),
              ListTile(
                title: const Text('Email'),
                subtitle: Text(user.email),
                titleTextStyle: TextStyle(color: Colors.black, fontSize: 15),
                subtitleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
                leading: Icon(Icons.email),
              )
            ],
          ),
        ),
        loading: () => const CircularProgressIndicator(),
        error: (error, _) => Text('Error: $error'),
      )
    );
  }
}