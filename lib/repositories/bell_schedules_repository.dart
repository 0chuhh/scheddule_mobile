import 'package:schedule_mobile/data/bell_schedules_data.dart';
import 'package:schedule_mobile/models/bell_schedule_model.dart';

class BellSchedulesRepository {
  BellScheduleModel getBellScheduleById(int id) {
    return bellSchedules.firstWhere((bellSchedule) => bellSchedule.id == id);
  }
}

