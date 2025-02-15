import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wildfire/src/providers/auth_provider.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    return Form(
      key: _formKey,
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "WildFire",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 50),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Username or Email",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "enter some text";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Password",
                ),
                obscureText: true,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await ref.read(authProvider.notifier).login({
                      "username": _usernameController.text,
                      "password": _passwordController.text,
                    });
                    if (authState["error"]) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Failed to login"),
                      ));
                    } else {
                      context.go("/");
                    }
                  }
                },
                child: Text("Login"),
              ),
            ],
          ),
        ),
      )
    );
  }
}
