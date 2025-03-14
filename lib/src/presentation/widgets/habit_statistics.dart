import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wildfire/src/data/models/habit_model.dart';
import 'package:wildfire/src/utils/streak_utils.dart';

class HabitStatistics extends ConsumerWidget {
  const HabitStatistics({super.key, required this.habit});
  final Habit habit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (currentStreak, maxStreak) = getCurrAndMaxStreaks(habit.dates);
    final numCompletions = getNumCompletions(habit.dates);
    return Container(
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
          ),
          SizedBox(height: 20),
          Divider(),
          SizedBox(height: 20),
          Text("Completions", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                title: Text("This Week"),
                trailing: Text(numCompletions["week"].toString(), style: TextStyle(fontSize: 20)),
                subtitle: LinearProgressIndicator(value: numCompletions["week"]! / 7),
              ),
              ListTile(
                title: Text("This Month"),
                trailing: Text(numCompletions["month"].toString(), style: TextStyle(fontSize: 20)),
                subtitle: LinearProgressIndicator(value: numCompletions["month"]! / 30),
              ),
              ListTile(
                title: Text("This Year"),
                trailing: Text(numCompletions["year"].toString(), style: TextStyle(fontSize: 20)),
                subtitle: LinearProgressIndicator(value: numCompletions["year"]! / 365),
              ),
            ],
          )
        ]
      )
    );
  }
}