import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.onPressed,
    required this.isLoading,
    required this.labelText
  });
  final VoidCallback onPressed;
  final bool isLoading;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      child: isLoading
          ? CircularProgressIndicator(color: Theme.of(context).colorScheme.onPrimary)
          : Text(labelText),
    );
  }
}
