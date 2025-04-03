import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wildfire/src/presentation/screens/error.dart';
import 'package:wildfire/src/presentation/widgets/name_edit.dart';
import 'package:wildfire/src/presentation/widgets/profile_pic_edit.dart';
import 'package:wildfire/src/providers/auth_provider.dart';
import 'package:wildfire/src/providers/user_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsyncValue = ref.watch(currUserProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            tooltip: 'Logout',
            onPressed: () {
              showDialog(
                context: context,
                builder: (dialogContext) {
                  return AlertDialog.adaptive(
                    title: const Text('Logout'),
                    content: const Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                        onPressed: () => context.pop(),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: colorScheme.error,
                        ),
                        onPressed: () {
                          ref.read(loginProvider.notifier).logout();
                          context.pop();
                        },
                        child: const Text('Logout'),
                      ),
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
      body: userAsyncValue.when(
        // ----- Data State -----
        data: (user) {
          if (user == null) {
            return Center(
              child: Text(
                'User data not available.',
                style: textTheme.bodyLarge?.copyWith(color: colorScheme.outline),
              ),
            );
          }
          // Use ListView for scrollability, especially on smaller screens
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Center(child: ProfilePicEdit(user: user)),
              const SizedBox(height: 24),
              Center(child: NameEdit(user: user)),
              ListTile(
                leading: Icon(Icons.alternate_email, color: colorScheme.secondary),
                title: Text(
                  'Username',
                   style: textTheme.labelLarge?.copyWith(color: colorScheme.onSurfaceVariant),
                ),
                subtitle: Text(
                  user.username,
                  style: textTheme.bodyLarge,
                ),
              ),

              ListTile(
                leading: Icon(Icons.email_outlined, color: colorScheme.secondary),
                title: Text(
                  'Email',
                  style: textTheme.labelLarge?.copyWith(color: colorScheme.onSurfaceVariant),
                ),
                subtitle: Text(
                  user.email,
                  style: textTheme.bodyLarge,
                ),
              ),
            ],
          );
        },
        // ----- Loading State -----
        loading: () => const Center(child: CircularProgressIndicator()), // Center the indicator

        // ----- Error State -----
        error: (error, stackTrace) {
           debugPrint("Error loading user: $error\n$stackTrace");
           return ErrorScreen(
             errorMsg: "Couldn't load profile",
             provider: currUserProvider,
           );
        },
      ),
    );
  }
}
