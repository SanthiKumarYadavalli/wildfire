import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wildfire/src/providers/auth_provider.dart';
import 'package:wildfire/src/providers/user_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currUserProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Wildfire"),
        actions: [
          MenuAnchor(
            menuChildren: [
              MenuItemButton(
                onPressed: () => ref.read(authProvider.notifier).logout(),
                leadingIcon: Icon(Icons.logout),
                child: Text("Logout"),
              )
            ],
            builder: (context, controller, child) {
              return user.when(
                data: (data) {
                  return IconButton(
                    icon: CircleAvatar(
                      backgroundImage: NetworkImage(data!.profileImageUrl),
                    ),
                    onPressed: () {
                      if (controller.isOpen) {
                        controller.close();
                      } else {
                        controller.open();
                      }
                    }
                  );
                },
                loading: () => CircularProgressIndicator(),
                error: (error, stackTrace) => Icon(Icons.error),
              );
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
        child: user.when(
          data: (data) => Text("Hello ${data!.name}! 👋", style: TextStyle(fontSize: 20)),
          loading: () => CircularProgressIndicator(),
          error: (error, stackTrace) => Text("Error: $error"),
        )
      ),
    );
  }
}