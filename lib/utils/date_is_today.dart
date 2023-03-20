bool dateIsToday(DateTime date) {
  final now = DateTime.now();
  final today = DateTime.utc(now.year, now.month, now.day);

  final selectedDate = DateTime.utc(date.year, date.month, date.day);

  if (today.compareTo(selectedDate) == 0) {
    return true;
  }
  return false;
}
