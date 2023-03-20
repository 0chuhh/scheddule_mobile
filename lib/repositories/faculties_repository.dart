import 'package:schedule_mobile/models/faculty_model.dart';

class FacultiesRepository {
  List<FacultyModel> getFaculties() {
    return faculties;
  }

  FacultyModel getFacultyById(int id) {
    return faculties.firstWhere((faculty) => faculty.id == id);
  }
}

List<FacultyModel> faculties = [
  FacultyModel(
    id: 1,
    name: 'Факультет строительства и экологии',
    bellScheduleId: 1,
  ),
  FacultyModel(
    id: 2,
    name: 'Факультет экономики и управлени',
    bellScheduleId: 1,
  ),
  FacultyModel(
    id: 3,
    name: 'Энергетический факультет',
    bellScheduleId: 1,
  ),
  FacultyModel(
    id: 4,
    name: 'Горный факультет',
    bellScheduleId: 1,
  ),
  FacultyModel(
    id: 5,
    name: 'Историко-филологический факультет',
    bellScheduleId: 1,
  ),
  FacultyModel(
    id: 6,
    name: 'Юридический факультет',
    bellScheduleId: 1,
  ),
  FacultyModel(
    id: 7,
    name: 'Факультет культуры и искусств',
    bellScheduleId: 1,
  ),
  FacultyModel(
    id: 8,
    name: 'Факультет физической культуры и спорта',
    bellScheduleId: 1,
  ),
  FacultyModel(
    id: 9,
    name: 'Факультет естественный наук, математики и технологий',
    bellScheduleId: 1,
  ),
  FacultyModel(
    id: 10,
    name: 'Социологический факультет',
    bellScheduleId: 1,
  ),
  FacultyModel(
    id: 11,
    name: 'Психолого-педагогический факульте',
    bellScheduleId: 1,
  ),
];
