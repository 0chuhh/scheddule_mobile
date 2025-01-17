import 'package:schedule_mobile/models/bell_schedule_model.dart';

List<BellScheduleModel> bellSchedules = [
  BellScheduleModel(
      id: 1,
      bigBreak: TimeRange(start: '13:35', end: '14:45'),
      firstLesson: TimeRange(start: '08:30', end: '10:05'),
      secondLesson: TimeRange(start: '10:15', end: '11:50'),
      thirdLesson: TimeRange(start: '12:00', end: '13:35'),
      fourthLesson: TimeRange(start: '14:35', end: '16:10'),
      fifthLesson: TimeRange(start: '16:20', end: '17:55'),
      sixthLesson: TimeRange(start: '18:05', end: '19:40'),
      seventhLesson: TimeRange(start: '19:50', end: '21:25')
  ),
  BellScheduleModel(
      id: 2,
      bigBreak: TimeRange(start: '13:35', end: '14:05'),
      firstLesson: TimeRange(start: '08:30', end: '10:05'),
      secondLesson: TimeRange(start: '10:15', end: '11:50'),
      thirdLesson: TimeRange(start: '12:00', end: '13:35'),
      fourthLesson: TimeRange(start: '14:05', end: '15:40'),
      fifthLesson: TimeRange(start: '15:50', end: '17:25'),
      sixthLesson: TimeRange(start: '17:35', end: '19:10'),
      seventhLesson: TimeRange(start: '19:20', end: '20:55')
  ),
];
