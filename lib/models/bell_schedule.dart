class BellScheduleModel {
  BellScheduleModel({
    required this.id,
    required this.bigBreak,
    required this.firstLesson,
    required this.secondLesson,
    required this.thirdLesson,
    required this.fourthLesson,
    required this.fifthLesson,
    required this.sixthLesson,
  });

  int id;
  TimeRange bigBreak;
  TimeRange firstLesson;
  TimeRange secondLesson;
  TimeRange thirdLesson;
  TimeRange fourthLesson;
  TimeRange fifthLesson;
  TimeRange sixthLesson;
}

class TimeRange {
  TimeRange({
    required this.start,
    required this.end,
  });

  String start;
  String end;
}