class Couple {
  int number;
  DateTime time;

  Couple({required this.number, required this.time});
}

enum ScheduleItemFormat { lection, practice, laboratory }

class ScheduleItem {
  Couple couple;
  String name;
  ScheduleItemFormat format;
  String lecturer;
  String cathedra;
  String classroom;

  ScheduleItem(
      {required this.couple,
      required this.name,
      required this.lecturer,
      required this.cathedra,
      required this.classroom,
      required this.format});
}
