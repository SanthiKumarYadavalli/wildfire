import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wildfire/src/presentation/widgets/auth_button.dart';
import 'package:wildfire/src/providers/auth_provider.dart';

class ForgotPasswordScreen extends ConsumerWidget {
  ForgotPasswordScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forgotPassword = ref.watch(forgotPasswordProvider);
    ref.listen(forgotPasswordProvider, (_, state) {
      if (state is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.error.toString()),
        ));
      } else if (state is AsyncData && state.value == true) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Password reset link sent to ${_emailController.text}"),
        ));
        _emailController.clear();
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "Enter your email to receive a password reset link.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email is required';
                  }
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value.trim())) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              AuthButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ref.read(forgotPasswordProvider.notifier).sendPasswordResetEmail(_emailController.text);
                  }
                },
                labelText: "Send Reset Link",
                isLoading: forgotPassword is AsyncLoading,
              )
            ],
          ),
        ),
      ),
    );
  }
}