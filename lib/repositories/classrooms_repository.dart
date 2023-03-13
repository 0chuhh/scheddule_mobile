import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:schedule_mobile/models/classroom_model.dart';

class ClassroomsRepository {
  Future<List<ClassroomModel>> getClassrooms() async {
    final response = await Dio()
        .get('https://zabgu.ru/modules/raspisanie/api/classrooms.php');
    final data = jsonDecode(response.data) as List;
    final classroomsList = data
        .map((e) => ClassroomModel(classroom: (e as Map<String, dynamic>)['kabinet']))
        .toList();
    return classroomsList;
  }
}