import 'package:dio/dio.dart';
import 'package:schedule_mobile/models/schedule_model.dart';
import 'dart:convert';

// final List<ScheduleModel> schedule = [
//   ScheduleModel(
//       weekType: WeekType.upper,
//       weekDay: 0,
//       couple: Couple(number: 2, time: DateTime(2023, 1, 1, 8, 30)),
//       name: 'Информационные технологии в цифровой экономике',
//       lecturer: 'Яковлева Лидия Леонидовна',
//       cathedra: 'ПиМ',
//       classroom: '03-401',
//       format: ScheduleItemFormat.lection),
//   ScheduleModel(
//       weekType: WeekType.upper,
//       weekDay: 0,
//       couple: Couple(number: 2, time: DateTime(2023, 1, 1, 10, 15)),
//       name: 'Администрирование и конфигурирование системы 1С:Предприятия',
//       lecturer: 'Иванов Александр Владимирович',
//       cathedra: 'ПиМ',
//       classroom: '03-401',
//       format: ScheduleItemFormat.lection),
//   ScheduleModel(
//       weekType: WeekType.upper,
//       weekDay: 0,
//       couple: Couple(number: 3, time: DateTime(2023, 1, 1, 12, 00)),
//       name: 'Администрирование и конфигурирование системы 1С:Предприятия',
//       lecturer: 'Иванов Александр Владимирович',
//       cathedra: 'ПиМ',
//       classroom: '03-401',
//       format: ScheduleItemFormat.laboratory),
//   ScheduleModel(
//       weekType: WeekType.upper,
//       weekDay: 2,
//       couple: Couple(number: 1, time: DateTime(2023, 1, 1, 8, 30)),
//       name: 'Математическая экономика',
//       lecturer: 'Глазырина Ирина Петровна',
//       cathedra: 'ПиМ',
//       classroom: '03-401',
//       format: ScheduleItemFormat.lection),
//   ScheduleModel(
//       weekType: WeekType.upper,
//       weekDay: 2,
//       couple: Couple(number: 2, time: DateTime(2023, 1, 1, 10, 15)),
//       name: 'Математическая экономика',
//       lecturer: 'Глазырина Ирина Петровна',
//       cathedra: 'ПиМ',
//       classroom: '03-401',
//       format: ScheduleItemFormat.practice),
//   ScheduleModel(
//       weekType: WeekType.upper,
//       weekDay: 2,
//       couple: Couple(number: 4, time: DateTime(2023, 1, 1, 16, 20)),
//       name: 'Математическое и имитационное моделирование',
//       lecturer: 'Лавлинский Сергей Михайлович',
//       cathedra: 'ПиМ',
//       classroom: '03-401',
//       format: ScheduleItemFormat.laboratory),
//   ScheduleModel(
//       weekType: WeekType.upper,
//       weekDay: 3,
//       couple: Couple(number: 1, time: DateTime(2023, 1, 1, 8, 30)),
//       name: 'Программирование в 1С',
//       lecturer: 'Орлова Евгения Александровна',
//       cathedra: 'ПиМ',
//       classroom: '03-401',
//       format: ScheduleItemFormat.laboratory),
//   ScheduleModel(
//       weekType: WeekType.upper,
//       weekDay: 3,
//       couple: Couple(number: 2, time: DateTime(2023, 1, 1, 10, 15)),
//       name: 'Программирование в 1С',
//       lecturer: 'Орлова Евгения Александровна',
//       cathedra: 'ПиМ',
//       classroom: '03-401',
//       format: ScheduleItemFormat.lection),
//   ScheduleModel(
//       weekType: WeekType.upper,
//       weekDay: 3,
//       couple: Couple(number: 3, time: DateTime(2023, 1, 1, 12, 00)),
//       name: 'Разработка программных приложений',
//       lecturer: 'Макаров Степан Александрович',
//       cathedra: 'ПиМ',
//       classroom: '03-401',
//       format: ScheduleItemFormat.laboratory),
//   ScheduleModel(
//       weekType: WeekType.upper,
//       weekDay: 4,
//       couple: Couple(number: 1, time: DateTime(2023, 1, 1, 8, 30)),
//       name: 'Банковские информационные системы',
//       lecturer: 'Петров Олег Игоревич',
//       cathedra: 'ПиМ',
//       classroom: '03-401',
//       format: ScheduleItemFormat.laboratory),
//   ScheduleModel(
//       weekType: WeekType.upper,
//       weekDay: 4,
//       couple: Couple(number: 2, time: DateTime(2023, 1, 1, 10, 15)),
//       name: 'Исследование операций и методы оптимизации',
//       lecturer: 'Фалейчик Андрей Анатольевич',
//       cathedra: 'ПиМ',
//       classroom: '03-401',
//       format: ScheduleItemFormat.lection),
//   ScheduleModel(
//       weekType: WeekType.upper,
//       weekDay: 4,
//       couple: Couple(number: 3, time: DateTime(2023, 1, 1, 12, 00)),
//       name: 'Администрирование и конфигурирование системы 1С:Предприятия',
//       lecturer: 'Иванов Александр Владимирович',
//       cathedra: 'ПиМ',
//       classroom: '03-401',
//       format: ScheduleItemFormat.laboratory),
//   ScheduleModel(
//       weekType: WeekType.upper,
//       weekDay: 4,
//       couple: Couple(number: 4, time: DateTime(2023, 1, 1, 16, 20)),
//       name: 'Компьютерная графика',
//       lecturer: 'Абдеева Наталья Анатольевна',
//       cathedra: 'ПиМ',
//       classroom: '03-401',
//       format: ScheduleItemFormat.laboratory),
//   ScheduleModel(
//       weekType: WeekType.lower,
//       weekDay: 0,
//       couple: Couple(number: 2, time: DateTime(2023, 1, 1, 8, 30)),
//       name: 'Информационные технологии в цифровой экономике',
//       lecturer: 'Яковлева Лидия Леонидовна',
//       cathedra: 'ПиМ',
//       classroom: '03-401',
//       format: ScheduleItemFormat.lection),
//   ScheduleModel(
//       weekType: WeekType.lower,
//       weekDay: 0,
//       couple: Couple(number: 2, time: DateTime(2023, 1, 1, 10, 15)),
//       name: 'Администрирование и конфигурирование системы 1С:Предприятия',
//       lecturer: 'Иванов Александр Владимирович',
//       cathedra: 'ПиМ',
//       classroom: '03-401',
//       format: ScheduleItemFormat.lection),
//   ScheduleModel(
//       weekType: WeekType.lower,
//       weekDay: 0,
//       couple: Couple(number: 3, time: DateTime(2023, 1, 1, 12, 00)),
//       name: 'Администрирование и конфигурирование системы 1С:Предприятия',
//       lecturer: 'Иванов Александр Владимирович',
//       cathedra: 'ПиМ',
//       classroom: '03-401',
//       format: ScheduleItemFormat.laboratory),
//   ScheduleModel(
//       weekType: WeekType.lower,
//       weekDay: 2,
//       couple: Couple(number: 1, time: DateTime(2023, 1, 1, 8, 30)),
//       name: 'Математическая экономика',
//       lecturer: 'Глазырина Ирина Петровна',
//       cathedra: 'ПиМ',
//       classroom: '03-401',
//       format: ScheduleItemFormat.lection),
//   ScheduleModel(
//       weekType: WeekType.lower,
//       weekDay: 2,
//       couple: Couple(number: 4, time: DateTime(2023, 1, 1, 16, 20)),
//       name: 'Математическое и имитационное моделирование',
//       lecturer: 'Лавлинский Сергей Михайлович',
//       cathedra: 'ПиМ',
//       classroom: '03-401',
//       format: ScheduleItemFormat.laboratory),
//   ScheduleModel(
//       weekType: WeekType.lower,
//       weekDay: 3,
//       couple: Couple(number: 1, time: DateTime(2023, 1, 1, 8, 30)),
//       name: 'Программирование в 1С',
//       lecturer: 'Орлова Евгения Александровна',
//       cathedra: 'ПиМ',
//       classroom: '03-401',
//       format: ScheduleItemFormat.laboratory),
//   ScheduleModel(
//       weekType: WeekType.lower,
//       weekDay: 3,
//       couple: Couple(number: 3, time: DateTime(2023, 1, 1, 12, 00)),
//       name: 'Разработка программных приложений',
//       lecturer: 'Макаров Степан Александрович',
//       cathedra: 'ПиМ',
//       classroom: '03-401',
//       format: ScheduleItemFormat.laboratory),
//   ScheduleModel(
//       weekType: WeekType.lower,
//       weekDay: 4,
//       couple: Couple(number: 1, time: DateTime(2023, 1, 1, 8, 30)),
//       name: 'Банковские информационные системы',
//       lecturer: 'Петров Олег Игоревич',
//       cathedra: 'ПиМ',
//       classroom: '03-401',
//       format: ScheduleItemFormat.laboratory),
//   ScheduleModel(
//       weekType: WeekType.lower,
//       weekDay: 4,
//       couple: Couple(number: 3, time: DateTime(2023, 1, 1, 12, 00)),
//       name: 'Администрирование и конфигурирование системы 1С:Предприятия',
//       lecturer: 'Иванов Александр Владимирович',
//       cathedra: 'ПиМ',
//       classroom: '03-401',
//       format: ScheduleItemFormat.laboratory),
// ];

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
