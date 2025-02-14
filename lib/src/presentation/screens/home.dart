import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wildfire"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              context.go("/login");
            },
          )
        ],
      ),
      body: Center(
        child: Text("Welcome!")
      ),
    );
  }
}