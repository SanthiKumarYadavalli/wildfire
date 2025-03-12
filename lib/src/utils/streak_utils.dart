List<DateTime> getSortedDates(Map<String, int> dates) {
  List<DateTime> sortedDates = dates.keys.map((date) => DateTime.parse(date)).toList();
  sortedDates.sort();
  return sortedDates;
}

(int, int) getCurrAndMaxStreaks(Map<String, int> dates) {
  List<DateTime> sortedDates = getSortedDates(dates);
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


bool isThisWeek(DateTime date) {
  DateTime today = DateTime.now();
  return today.difference(date).inDays < 7 && today.weekday >= date.weekday;
}


Map<String, int> getNumCompletions(Map<String, int> dates) {
  Map<String, int> numCompletions = {
    "month": 0,
    "week": 0,
    "year": 0,
  };
  DateTime today = DateTime.now();
  List<DateTime> sortedDates = getSortedDates(dates);
  for (int i = 0; i < sortedDates.length; i++) {
    DateTime curr = sortedDates[i];
    if (curr.year == today.year) {
      numCompletions["year"] = numCompletions["year"]! + 1;
      if (curr.month == today.month) {
        numCompletions["month"] = numCompletions["month"]! + 1;
      }
    }
    if (isThisWeek(curr)) {
      numCompletions["week"] = numCompletions["week"]! + 1;
    }
  }
  return numCompletions;
}
