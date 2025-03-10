import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wildfire/src/providers/habit_provider.dart';
import 'package:wildfire/src/utils/streak_utils.dart';

class HabitScreen extends ConsumerWidget {
  const HabitScreen({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habits = ref.watch(userHabitsProvider).requireValue;
    final habit = habits.firstWhere((element) => element.id == id);
    final (currentStreak, maxStreak) = getCurrAndMaxStreaks(habit.dates);
    return Scaffold(
      appBar: AppBar(
        title: Text("Habit"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Column(
              children: [
                Text(habit.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(habit.description),
              ],
            ),
            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 20),
            Text("Streaks", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Card( 
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text('Current'),
                          Text(
                            currentStreak.toString(),
                            style: TextStyle(
                              fontSize: Theme.of(context).textTheme.displaySmall!.fontSize,
                              fontWeight: Theme.of(context).textTheme.displaySmall!.fontWeight,
                              color: Theme.of(context).textTheme.displaySmall!.color
                            ),
                          )
                        ]
                      ),
                    )
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text('Best'),
                          Text(
                            maxStreak.toString(),
                            style: TextStyle(
                              fontSize: Theme.of(context).textTheme.displaySmall!.fontSize,
                              fontWeight: Theme.of(context).textTheme.displaySmall!.fontWeight,
                              color: Theme.of(context).textTheme.displaySmall!.color
                            ),
                          )
                        ]
                      ),
                    )
                  ),
                )
              ],
            )
          ]
        )
      )
    );
  }
}