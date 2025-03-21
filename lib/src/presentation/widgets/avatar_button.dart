import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wildfire/src/providers/user_provider.dart';

class AvatarButton extends ConsumerWidget {
  const AvatarButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currUserProvider);
    return IconButton(
      icon: CircleAvatar(
        foregroundImage: user.whenOrNull(
          data: (data) => NetworkImage(data!.profileImageUrl),
        ),
      ),
      onPressed: () {
        context.push('/profile');
      }
    );
  }
}
