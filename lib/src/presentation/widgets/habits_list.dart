import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:wildfire/src/data/models/habit_model.dart';
import 'package:wildfire/src/providers/date_provider.dart';
import 'package:wildfire/src/providers/habit_provider.dart';

class HabitsList extends ConsumerWidget {
  const HabitsList({super.key, required this.data});
  final List<Habit> data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loadingHabits = ref.watch(loadingHabitsProvider);
    final currDate = ref.watch(currDateProvider);

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final formattedDate = DateFormat("yyyy-MM-dd").format(currDate);

    Widget buildEmptyState() {
      return LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView( // Ensures it's scrollable for RefreshIndicator
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.list,
                        size: 60,
                        color: colorScheme.secondary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "No habits found.",
                        style: textTheme.headlineSmall?.copyWith(
                            color: colorScheme.onSurfaceVariant),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Pull down to refresh or add a new habit.",
                        style: textTheme.bodyMedium
                            ?.copyWith(color: colorScheme.outline),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    }


    // ----- Main List Build -----
    return RefreshIndicator(
      color: colorScheme.primary,
      onRefresh: () async {
        try {
          return await ref.refresh(userHabitsProvider.future);
        } catch (e, stackTrace) {
          debugPrint("Error refreshing habits: $e\n$stackTrace");
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Failed to refresh habits: ${e.toString()}")));
          }
        }
      },
      child: (data.isEmpty)
        ? buildEmptyState()
        : ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 88), // Keep bottom padding for potential FAB/nav bar
            itemCount: data.length,
            itemBuilder: (context, index) {
              final habit = data[index];
              final isCompleted = habit.dates.containsKey(formattedDate);
              final isLoading = loadingHabits.contains(habit.id);

              return Card(
                elevation: isLoading ? 0 : 1, // Subtle elevation, none when loading
                color: isLoading
                    ? colorScheme.surfaceContainerHighest.withValues(alpha: 0.5)
                    : colorScheme.surface,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  // Side border for completion indicator (alternative to icon color)
                  side: BorderSide(
                    color: isCompleted && !isLoading ? colorScheme.primary : colorScheme.outlineVariant,
                    width: 2,
                  ),
                ),
                clipBehavior: Clip.antiAlias, // Ensures content respects border radius
                child: Stack( // Stack for potential loading overlay
                  children: [
                    ListTile(
                      enabled: !isLoading,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      leading: Icon(Icons.favorite, color: colorScheme.secondary),
                      title: Text(
                        habit.title,
                        style: textTheme.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          isCompleted
                              ? Icons.local_fire_department
                              : Icons.local_fire_department_outlined,
                          color: isCompleted ? colorScheme.primary : colorScheme.outline,
                          size: 28,
                        ),
                        tooltip: isCompleted
                            ? 'Mark as incomplete'
                            : 'Mark as complete',
                        onPressed: () {
                            ref
                              .read(userHabitsProvider.notifier)
                              .toggleCompletion(habit.id, formattedDate);
                        },
                      ),
                      onTap: () {
                        context.push("/habit/${habit.id}");
                      },
                    ),

                    // ----- Loading Overlay -----
                    if (isLoading)
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                              color: colorScheme.surface.withValues(alpha: 0.6), // Scrim color
                              borderRadius: BorderRadius.circular(12) // Match card shape
                          ),
                          child: const Center(
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                              ),
                            ),
                          ),
                        ),
                      ),
                    // ----- End Loading Overlay -----
                  ],
                ),
              );
            },
          ),
    );
  }
}