var months = {
  'Jan': [1, 'Янв'],
  'Feb': [2, 'Фер'],
  'Mar': [3, 'Мар'],
  'Apr': [4, 'Апр'],
  'May': [5, 'Май'],
  'Jun': [6, 'Июн'],
  'Jul': [7, 'Июл'],
  'Aug': [8, 'Авг'],
  'Sep': [9, 'Сен'],
  'Oct': [10, 'Окт'],
  'Nov': [11, 'Ноя'],
  'Dec': [12, 'Дек']
};

List<dynamic>? getDateFromExtremular(String dateString) {
  if (dateString.contains('-')) {
    final date = dateString.split('-');
    final day = int.parse(date[0]);
    final int month = (months as Map<String, List>)[date[1]]![0];
    final String strMonth = (months as Map<String, List>)[date[1]]![1];
    return [DateTime(DateTime.now().year, month, day), '$day-$strMonth'];
  }
  return null;
}
