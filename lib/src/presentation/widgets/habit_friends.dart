import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wildfire/src/providers/habit_provider.dart';

class HabitFriends extends ConsumerWidget {
  const HabitFriends({super.key, required this.habitId});
  final String habitId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final friends = ref.watch(habitFriendsProvider(habitId));
    ref.listen(habitFriendsProvider(habitId), (_, state) {
      if (state is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Failed to get friends"),
        ));
      }
    });
    return friends.when(
      data: (friends) {
        return Container(
          padding: EdgeInsets.all(20),
          child: RefreshIndicator(
            onRefresh: () => ref.refresh(habitFriendsProvider(habitId).future),
            child: ListView.builder(
            itemCount: friends.length,
            itemBuilder: (context, index) {
              final friend = friends[index];
              return ListTile(
                title: Text(friend.profile.username),
                subtitle: Text("Completed ${friend.dates.length} times"),
              );
            },
          ),
        ));
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text("Failed to get friends")),
    );
  }
}