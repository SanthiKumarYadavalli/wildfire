import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ErrorScreen extends ConsumerWidget {
  const ErrorScreen({super.key, required this.errorMsg, required this.provider});
  final String errorMsg;
  final ProviderBase provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error, size: 50, color: Colors.red),
        SizedBox(height: 16),
        Text(
          errorMsg,
          style: TextStyle(fontSize: 18, color: Colors.red),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            ref.invalidate(provider);
          },
          child: Text("Retry"),
        )
      ],
    ));
  }
}
