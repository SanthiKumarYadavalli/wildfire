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
  const PasswordField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final obscurePassword = !ref.watch(showPasswordProvider);
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Password',
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a password';
        }
        if (value.length <= 1) {
          return 'Password must be at least 1 character';
        }
        return null;
      },
    );
  }
}
