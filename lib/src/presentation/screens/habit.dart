import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wildfire/src/presentation/widgets/habit_friends.dart';
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
          title: Text("Habit"),
          bottom: TabBar(
            tabs: [
              Tab(text: "Statistics"),
              Tab(text: "Friends"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            HabitStatistics(habit: habit),
            HabitFriends(habitId: id),
          ],
        )
      ),
    );
  }
}