import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:schedule_mobile/models/lecturer_model.dart';

class LecturersRepository {
  Future<List<LecturerModel>> getLecturers() async {
    final response = await Dio()
        .get('https://zabgu.ru/modules/raspisanie/api/lecturers.php');
    final data = jsonDecode(response.data) as List;
    final lecturerList = data
        .map((e) => LecturerModel(name: (e as Map<String, dynamic>)['people']))
        .toList();
    return lecturerList;
  }

  Future<void> getLecturersByName(String lecturerName) async {
    final response = await Dio().get(
        'https://zabgu.ru/modules/raspisanie/api/lecturers.php',
        queryParameters: {'lecturerName': lecturerName});
    final data = jsonDecode(response.data);
    final lecturerList = data
        .map((e) => LecturerModel(name: (e as Map<String, dynamic>)['people']))
        .toList();
    return lecturerList;
  }
}
