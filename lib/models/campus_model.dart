import 'package:schedule_mobile/models/faculty_model.dart';

class CampusModel {
  CampusModel({
    required this.id,
    required this.address,
    required this.faculties,
    required this.bellScheduleId,
  });

  int id;
  String address;
  List<FacultyModel> faculties;
  int bellScheduleId;
}
