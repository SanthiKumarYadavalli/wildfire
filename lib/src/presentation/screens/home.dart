import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wildfire/src/providers/auth_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wildfire"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              ref.read(authProvider.notifier).logout();
              context.go("/login");
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Added a new habit!");
        },
        tooltip: "Add a new habit",
        child: Icon(Icons.add),
      ),
      body: Center(
        child: Text("Add a habit!")
      ),
    );
  }
}