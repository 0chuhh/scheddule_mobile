import 'package:dio/dio.dart';
import 'package:schedule_mobile/models/schedule_model.dart';
import 'dart:convert';

class SchedulesRepository {
  Future<List<ScheduleModel>> getSchedulesByGroup(String group) async {
    final response = await Dio().get(
        'https://zabgu.ru/modules/raspisanie/api/schedule/group.php',
        queryParameters: {'groupName': group});
    final data = jsonDecode(response.data) as List;
    final schedule = data.map((json) => ScheduleModel.fromJson(json)).toList();
    schedule.sort(((a, b) => a.couple.number.compareTo(b.couple.number)));
    return schedule;
  }

  Future<List<ScheduleModel>> getScheduleByClassroom(String classroom) async {
    final response = await Dio().get(
        'https://zabgu.ru/modules/raspisanie/api/schedule/classroom.php',
        queryParameters: {'classroom': classroom});
    final data = jsonDecode(response.data) as List;
    final schedule = data.map((json) => ScheduleModel.fromJson(json)).toList();
    schedule.sort(((a, b) => a.couple.number.compareTo(b.couple.number)));
    return schedule;
  }

  Future<List<ScheduleModel>> getScheduleByLecturer(
      String lecturer, String format) async {
    final response = await Dio().get(
        'https://zabgu.ru/modules/raspisanie/api/schedule/lecturer.php',
        queryParameters: {'lecturerName': lecturer, 'studyForm': format});
    final data = jsonDecode(response.data) as List;
    final schedule = data.map((json) => ScheduleModel.fromJson(json)).toList();
    schedule.sort(((a, b) => a.couple.number.compareTo(b.couple.number)));
    return schedule;
  }
}
