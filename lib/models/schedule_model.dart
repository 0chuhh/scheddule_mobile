class Couple {
  int number;
  DateTime time;

  Couple({required this.number, required this.time});
}

enum ScheduleItemFormat { lection, practice, laboratory }

enum WeekType { upper, lower }

class ScheduleModel {
  int weekDay;
  WeekType weekType;
  Couple couple;
  String name;
  ScheduleItemFormat format;
  String lecturer;
  String cathedra;
  String classroom;

  ScheduleModel(
      {required this.weekDay,
      required this.weekType,
      required this.couple,
      required this.name,
      required this.lecturer,
      required this.cathedra,
      required this.classroom,
      required this.format});
}
