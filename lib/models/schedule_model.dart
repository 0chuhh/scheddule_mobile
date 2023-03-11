import 'dart:convert';

import 'package:schedule_mobile/models/bell_schedule_model.dart';
import 'package:schedule_mobile/repositories/bell_schedules_repository.dart';

class Couple {
  int number;
  DateTime time;

  Couple({required this.number, required this.time});
}

enum ScheduleItemFormat { lection, practice, laboratory }

enum WeekType { upper, lower }

class ScheduleModel {
  String weekDay;
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

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    final BellScheduleModel bellSchedules =
        BellSchedulesRepository().getBellScheduleById(1);
    final DateTime time;
    final int coupleNum = int.parse(json['num']);
    DateTime getCoupleTimeByNum(int num) {
      final now = DateTime.now();
      switch (num) {
        case 1:
          return DateTime.parse(
              '${now.year}-${now.month > 9 ? now.month : '0${now.month}'}-${now.day > 9 ? now.day : '0${now.day}'} ${bellSchedules.firstLesson.start}:00.000');
        case 2:
          return DateTime.parse(
              '${now.year}-${now.month > 9 ? now.month : '0${now.month}'}-${now.day > 9 ? now.day : '0${now.day}'} ${bellSchedules.secondLesson.start}:00.000');
        case 3:
          return DateTime.parse(
              '${now.year}-${now.month > 9 ? now.month : '0${now.month}'}-${now.day > 9 ? now.day : '0${now.day}'} ${bellSchedules.thirdLesson.start}:00.000');
        case 4:
          return DateTime.parse(
              '${now.year}-${now.month > 9 ? now.month : '0${now.month}'}-${now.day > 9 ? now.day : '0${now.day}'} ${bellSchedules.fourthLesson.start}:00.000');
        case 5:
          return DateTime.parse(
              '${now.year}-${now.month > 9 ? now.month : '0${now.month}'}-${now.day > 9 ? now.day : '0${now.day}'} ${bellSchedules.fifthLesson.start}:00.000');
        case 6:
          return DateTime.parse(
              '${now.year}-${now.month > 9 ? now.month : '0${now.month}'}-${now.day > 9 ? now.day : '0${now.day}'} ${bellSchedules.sixthLesson.start}:00.000');
        default:
          return DateTime.parse(
              '${now.year}-${now.month > 9 ? now.month : '0${now.month}'}-${now.day > 9 ? now.day : '0${now.day}'} ${bellSchedules.firstLesson.start}:00.000');
      }
    }

    return ScheduleModel(
        weekDay: json['day'],
        weekType: json['type'] == 'н' ? WeekType.lower : WeekType.upper,
        couple: Couple(number: coupleNum, time: getCoupleTimeByNum(coupleNum)),
        name: json['predmet'],
        format: ScheduleItemFormat.lection,
        lecturer: json['people'],
        cathedra: json['kafedra'],
        classroom: json['kabinet']);
  }

  static Map<String, dynamic> toMap(ScheduleModel schedule) => {
        'weekDay': schedule.weekDay,
        'weekType': schedule.weekType.toString(),
        'coupleNum': schedule.couple.number,
        'coupleTime': schedule.couple.time.toString(),
        'name': schedule.name,
        'format': schedule.format.toString(),
        'lecturer': schedule.lecturer,
        'cathedra': schedule.cathedra,
        'classroom': schedule.classroom
      };

  static String encode(List<ScheduleModel> schedule) => json.encode(
        schedule
            .map<Map<String, dynamic>>(
                (schedule) => ScheduleModel.toMap(schedule))
            .toList(),
      );

  factory ScheduleModel.fromSharedPreferences(Map<String, dynamic> json) {
    return ScheduleModel(
        weekDay: json['weekDay'],
        weekType: json['weekType'] == 'WeekType.lower'
            ? WeekType.lower
            : WeekType.upper,
        couple: Couple(
            number: json['coupleNum'],
            time: DateTime.parse(json['coupleTime'])),
        name: json['name'],
        lecturer: json['lecturer'],
        cathedra: json['cathedra'],
        classroom: json['classroom'],
        format: json['format'] == 'ScheduleItemFormat.lection'
            ? ScheduleItemFormat.lection
            : json['format'] == 'ScheduleItemFormat.practice'
                ? ScheduleItemFormat.practice
                : ScheduleItemFormat.laboratory);
  }

  static List<ScheduleModel> decode(String schedule) => (json.decode(schedule)
          as List<dynamic>)
      .map<ScheduleModel>((item) => ScheduleModel.fromSharedPreferences(item))
      .toList();
}
