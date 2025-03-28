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
    ref.listen(habitFriendsProvider(habitId), (_, state) {
      if (state is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Failed to get friends"),
        ));
      }
    });
    return friendStats.when(
      data: (friendStats) {
        return RefreshIndicator(
          onRefresh: () => ref.refresh(habitFriendsProvider(habitId).future),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height - 200,
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  DropdownMenu(
                    initialSelection: displayValue,
                    dropdownMenuEntries: [
                      DropdownMenuEntry(label: "This Week", value: "week"),
                      DropdownMenuEntry(label: "This Month", value: "month"),
                      DropdownMenuEntry(label: "This Year", value: "year"),
                      DropdownMenuEntry(label: "Streak", value: "streak"),
                    ],
                    onSelected: (value) {
                      ref.read(friendsDisplayValueProvider.notifier).update(value!);
                      ref.read(habitFriendsProvider(habitId).notifier).sortBySelectedValue(value);
                    },
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: friendStats.length,
                      itemBuilder: (context, index) {
                        final friend = friendStats[index]['friend'];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(friend.profile.profileImageUrl),
                          ),
                          title: Text(friend.profile.name),
                          trailing: Text(
                            friendStats[index][displayValue].toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, _) => ErrorScreen(
        errorMsg: "Can't get friends",
        provider: habitFriendsProvider(habitId)
      )
    );
  }
}
