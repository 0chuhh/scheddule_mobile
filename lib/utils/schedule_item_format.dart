import 'package:schedule_mobile/models/schedule_model.dart';

String getFormatName(ScheduleItemFormat? format) {
  switch (format) {
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
