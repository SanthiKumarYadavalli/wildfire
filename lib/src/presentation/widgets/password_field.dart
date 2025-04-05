import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'password_field.g.dart';

@riverpod
class ShowPassword extends _$ShowPassword {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
  }
}

class PasswordField extends ConsumerWidget {
  const PasswordField({super.key, required this.controller, this.labelText, this.validator});
  final TextEditingController controller;
  final String? labelText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final obscurePassword = !ref.watch(showPasswordProvider);
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText ?? 'Password',
        prefixIcon: const Icon(Icons.lock),
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(
            obscurePassword ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            ref.read(showPasswordProvider.notifier).toggle();
          },
        ),
      ),
      obscureText: obscurePassword,
      validator: validator ?? (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a password';
        }
        return null;
      },
    );
  }
}
