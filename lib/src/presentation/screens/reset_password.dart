import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wildfire/src/presentation/widgets/auth_button.dart';
import 'package:wildfire/src/presentation/widgets/password_field.dart';
import 'package:wildfire/src/providers/auth_provider.dart';

class ResetPasswordScreen extends ConsumerWidget {
  ResetPasswordScreen({super.key, required this.token});
  final String token;
  final formKey = GlobalKey<FormState>();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resetPasswordState = ref.watch(resetPasswordProvider);
    ref.listen<AsyncValue<void>>(resetPasswordProvider, (previous, next) {
      if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error.toString())),
        );
      } else if (next is AsyncData && next.value == true) {
        context.go('/login');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password reset successful')),
        );
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              PasswordField(
                controller: newPasswordController,
              ),
              const SizedBox(height: 16),
              PasswordField(
                controller: confirmPasswordController,
                labelText: 'Confirm Password',
                validator: (value) {
                  if (value != newPasswordController.text) return 'Passwords do not match';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              AuthButton(
                labelText: 'Reset Password',
                isLoading: resetPasswordState.isLoading,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    ref.read(resetPasswordProvider.notifier).resetPassword(
                      token, newPasswordController.text
                    );
                  }
                },
              )
            ],
          )
        )
      )
    );
  }
}