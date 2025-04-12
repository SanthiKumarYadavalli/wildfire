import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wildfire/src/presentation/screens/error.dart';
import 'package:wildfire/src/providers/habit_provider.dart';

class FriendsTab extends ConsumerWidget {
  const FriendsTab({super.key, required this.habitId, required this.friendStats});

  final String habitId;
  final AsyncValue<List<Map<String, dynamic>>> friendStats;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayValue = ref.watch(friendsDisplayValueProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    ref.listen(habitFriendsProvider(habitId), (_, state) {
      if (state is AsyncError && !state.isLoading) {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Failed to update friends list: ${state.error}"),
          backgroundColor: colorScheme.errorContainer,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.fromLTRB(15, 5, 15, 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ));
      }
    });

    final Map<String, String> options = {
      'week': 'This Week',
      'month': 'This Month',
      'year': 'This Year',
      'streak': 'Streak',
      'best_streak': 'Best Streak',
    };

    // Helper to get medal icons for top ranks
    Widget getRankIndicator(int rank, BuildContext context) {
      final colorScheme = Theme.of(context).colorScheme;
      switch (rank) {
        case 1:
          return Icon(Icons.emoji_events, color: Colors.amber.shade700, size: 26);
        case 2:
          return Icon(Icons.emoji_events, color: Colors.grey.shade500, size: 24);
        default:
          return Text(
            '$rank',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                ),
          );
      }
    }

    return friendStats.when(
      data: (statsList) {
        return RefreshIndicator(
          color: colorScheme.primary,
          onRefresh: () async {
            ref.invalidate(habitFriendsProvider(habitId));
            await ref.read(habitFriendsProvider(habitId).future);
          },
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Leaderboard", // Changed Title
                        style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: options.entries.map((entry) {
                          final bool isSelected = entry.key == displayValue;
                          return ChoiceChip(
                            label: Text(entry.value),
                            selected: isSelected,
                            onSelected: (selected) {
                              if (selected) {
                                ref.read(friendsDisplayValueProvider.notifier).update(entry.key);
                                ref.read(habitFriendsProvider(habitId).notifier).sortBySelectedValue(entry.key);
                              }
                            },
                            labelStyle: textTheme.labelLarge?.copyWith(
                              color: isSelected ? colorScheme.onSecondaryContainer : colorScheme.onSurfaceVariant,
                            ),
                            selectedColor: colorScheme.secondaryContainer,
                            side: isSelected ? null : BorderSide(color: colorScheme.outlineVariant),
                            showCheckmark: false,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),

              SliverList.builder(
                itemCount: statsList.length,
                itemBuilder: (context, index) {
                  final rank = index + 1;
                  final friendData = statsList[index];
                  final friendProfile = friendData['friend']?.profile;
                  final String name = friendProfile?.name ?? 'Unknown User';
                  final String imageUrl = friendProfile?.profileImageUrl ?? '';
                  final String statValue = friendData[displayValue]?.toString() ?? '--';
                  final String statLabel = options[displayValue] ?? displayValue;

                  Color? itemBackgroundColor = colorScheme.surface;
                  Color? itemForegroundColor = colorScheme.onSurfaceVariant;

                  if (friendData['friend'].isUser) {
                    itemBackgroundColor = colorScheme.secondaryContainer.withValues(alpha: 0.6);
                      itemForegroundColor = colorScheme.onSecondaryContainer;
                  }

                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: itemBackgroundColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 36,
                            alignment: Alignment.center,
                            child: getRankIndicator(rank, context),
                          ),
                          const SizedBox(width: 8),
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: colorScheme.inverseSurface,
                            foregroundImage: imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
                          ),
                        ],
                      ),
                      title: Text(
                        name,
                        style: textTheme.titleMedium?.copyWith(color: itemForegroundColor),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        statLabel,
                        style: textTheme.bodySmall?.copyWith(color: itemForegroundColor.withValues(alpha: 0.8)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Text(
                        statValue,
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) {
        debugPrint("Error loading friends tab: $error\n$stackTrace");
        return ErrorScreen(
          errorMsg: "Can't load friend stats",
          provider: habitFriendsProvider(habitId),
        );
      }
    );
  }
}