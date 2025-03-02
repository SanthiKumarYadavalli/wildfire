import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wildfire/src/presentation/widgets/password_field.dart';
import 'package:wildfire/src/providers/auth_provider.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(loginProvider);
    ref.listen(loginProvider, (_, state) {
      if (state is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.error.toString()),
        ));
      } else if (state is AsyncData && state.value != "") {
        context.go("/");
      }
    });
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
                  prefixIcon: const Icon(Icons.person),
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
              PasswordField(controller: _passwordController),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ref.read(loginProvider.notifier).login({
                      "username": _usernameController.text,
                      "password": _passwordController.text,
                    });
                  }
                },
                child: auth.isLoading ? CircularProgressIndicator() : Text("Login"),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      context.go('/signup');
                    },
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}
