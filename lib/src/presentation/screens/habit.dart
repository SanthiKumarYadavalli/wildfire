import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wildfire/src/presentation/widgets/friends_tab.dart';
import 'package:wildfire/src/presentation/widgets/habit_statistics.dart';
import 'package:wildfire/src/providers/habit_provider.dart';

class HabitScreen extends ConsumerWidget {
  const HabitScreen({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habits = ref.watch(userHabitsProvider).requireValue;
    final habit = habits.firstWhere((element) => element.id == id);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(habit.title),
          bottom: TabBar(
            tabs: [
              Tab(text: "Statistics"),
              Tab(text: "Friends"),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.delete_forever, color: Colors.red),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Are you sure?"),
                      content: const Text("This habit will be deleted permanently"),
                      actions: [
                        TextButton(
                          onPressed: () => context.pop(),
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            ref.read(userHabitsProvider.notifier).deleteHabit(id);
                            context.pop();
                            context.pop();
                          },
                          child: const Text("Delete", style: TextStyle(color: Colors.red)),
                        )
                      ],
                    );
                  }
                );
              },
            )
          ],
        ),
        body: TabBarView(
          children: [
            HabitStatistics(habit: habit),
            FriendsTab(habitId: id),
          ],
        )
      ),
    );
  }
}