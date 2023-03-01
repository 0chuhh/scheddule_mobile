class Couple {
  int? number;
  DateTime? time;

  Couple({this.number, this.time});
}

enum ScheduleItemFormat {
  lection,
  practice,
  laboratory
}

extension ScheduleItemFormatExtension on ScheduleItemFormat {

  String get name {
    switch (this) {
      case ScheduleItemFormat.lection:
        return 'Лекция';
      case ScheduleItemFormat.practice:
        return 'Практика';
      case ScheduleItemFormat.laboratory:
        return 'Лабораторная';
      default:
        return 'Лекция';
    }
  }

}

class ScheduleItem {
  Couple? couple;
  String? name;
  ScheduleItemFormat ? format;
  String? lecturer;
  String? cathedra;
  String? classroom;

  ScheduleItem(
      {this.couple, this.name, this.lecturer, this.cathedra, this.classroom});
}
