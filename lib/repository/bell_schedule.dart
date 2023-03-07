import 'package:schedule_mobile/models/bell_schedule.dart';

class BellScheduleRepository {
  BellScheduleModel getBellScheduleById(int id) {
    return bellSchedules.firstWhere((bellSchedule) => bellSchedule.id == id);
  }
}

List<BellScheduleModel> bellSchedules = [
  BellScheduleModel(
      id: 1,
      bigBreak: TimeRange(start: '13:35', end: '14:45'),
      firstLesson: TimeRange(start: '8:30', end: '10:05'),
      secondLesson: TimeRange(start: '10:15', end: '11:50'),
      thirdLesson: TimeRange(start: '12:00', end: '13:35'),
      fourthLesson: TimeRange(start: '14:35', end: '16:10'),
      fifthLesson: TimeRange(start: '16:20', end: '17:55'),
      sixthLesson: TimeRange(start: '18:05', end: '19:40')
  )
];
