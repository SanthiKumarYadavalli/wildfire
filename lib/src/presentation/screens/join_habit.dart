import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wildfire/src/providers/habit_provider.dart';

class HabitJoinScreen extends ConsumerWidget {
  const HabitJoinScreen({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitProvider = ref.watch(getHabitProvider(id));
    final joinFriend = ref.watch(joinFriendProvider(id));

    ref.listen(getHabitProvider(id), (_, state) {
      if (state is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${state.error}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        centerTitle: true,
      ),
      body: habitProvider.when(
        data: (habit) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Habit Title
                Text(
                  habit.title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 16),
                
                // Description Section
                Text(
                  'Description',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  habit.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.justify,
                ),
                
                const SizedBox(height: 24),
                
                Text(
                  'Created By',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  habit.createdBy,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const Spacer(),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (joinFriend.value == false) {
                        ref.read(joinFriendProvider(id).notifier).join();
                      } else {
                        ref.invalidate(userHabitsProvider);
                        context.go("/");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(300, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    child: joinFriend.when(
                      data: (isJoined) => Text(
                        isJoined ? 'Go to Home' : 'JOIN',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
                      ),
                      loading: () => const CircularProgressIndicator(color: Colors.white),
                      error: (error, _) => Text('JOIN HABIT!', style: TextStyle(color: Colors.white)),
                    )
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      )
    );
  }
}

