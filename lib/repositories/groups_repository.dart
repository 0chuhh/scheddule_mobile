import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:schedule_mobile/models/group_model.dart';

class GroupsRepository {
  Future<List<GroupModel>> getGroups() async {
    final response =
        await Dio().get('https://zabgu.ru/modules/raspisanie/api/groups.php');
    final data = jsonDecode(response.data) as List;
    final groupsList = data
        .map((e) => GroupModel(name: (e as Map<String, dynamic>)['group_name']))
        .toList();
    return groupsList;
  }

  Future<List<GroupModel>> getGroupsByName(String groupName) async {
    final response = await Dio().get(
        'https://zabgu.ru/modules/raspisanie/api/groups.php',
        queryParameters: {'groupName': groupName});
    final data = jsonDecode(response.data) as List;
    final groupsList = data
        .map((e) => GroupModel(name: (e as Map<String, dynamic>)['group_name']))
        .toList();
    return groupsList;
  }
}
