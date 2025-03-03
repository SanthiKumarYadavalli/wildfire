import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:wildfire/src/data/models/habit_model.dart';
import 'package:wildfire/src/providers/date_provider.dart';
import 'package:wildfire/src/providers/habit_provider.dart';

class HabitsList extends ConsumerWidget {
  const HabitsList({super.key, required this.data});
  final List<Habit> data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currDate = ref.watch(currDateProvider);
    return RefreshIndicator(
      onRefresh: () => ref.refresh(userHabitsProvider.future),
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 80),
        itemCount: data.length,
        itemBuilder: (context, index) {
          final formattedDate = DateFormat("yyyy-MM-dd").format(currDate);
          final isCompleted = data[index].dates.containsKey(formattedDate);
          return Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(149, 157, 165, 0.2),
                  blurRadius: 24,
                  spreadRadius: 0,
                  offset: Offset(0, 8),
                ),
              ],
              border: Border(
                left: BorderSide(
                  color: (isCompleted) ? Colors.deepOrange : Colors.grey,
                  width: 5,
                ),
              ),
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Text(
                data[index].title,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                  fontWeight: Theme.of(context).textTheme.titleMedium!.fontWeight,
                ),
              ),
              trailing: IconButton(
                icon: (isCompleted)
                    ? Icon(Icons.local_fire_department_sharp,
                        color: Colors.deepOrange, size: 40)
                    : Icon(Icons.local_fire_department_outlined,
                        color: Colors.grey, size: 40),
                onPressed: () {
                  ref.read(userHabitsProvider.notifier)
                     .toggleCompletion(data[index].id, formattedDate);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
