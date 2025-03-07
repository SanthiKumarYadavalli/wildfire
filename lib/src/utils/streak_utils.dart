
(int, int) getCurrAndMaxStreaks(Map<String, int> dates) {
  List<DateTime> sortedDates = dates.keys.map((date) => DateTime.parse(date)).toList();
  sortedDates.sort();
  if (sortedDates.isEmpty) return (0, 0);

  int streak = 1;
  int maxStreak = 0;
  for (int i = 1; i < sortedDates.length; i++) {
    if (sortedDates[i].difference(sortedDates[i - 1]).inDays == 1) {
      streak++;
    } else {
      maxStreak = streak > maxStreak ? streak : maxStreak;
      streak = 1;  // streak starts again
    }
  }
  maxStreak = streak > maxStreak ? streak : maxStreak;
  // If the last date is not today, the streak is broken
  if (DateTime.now().difference(sortedDates.last).inDays >= 1) {
    streak = 0;
  }
  return (streak, maxStreak);
}
