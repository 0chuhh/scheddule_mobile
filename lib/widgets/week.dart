import 'package:flutter/material.dart';

import '../models/schedule_model.dart';

class Week extends StatelessWidget {
  const Week({super.key, required this.date, this.textStyle});
  final DateTime date;
  final TextStyle? textStyle;

  String _getWeekString(){
    late DateTime d = DateTime(date.year, 1, 1);
    late int d0 = date.millisecondsSinceEpoch;
    late int d1 = d.millisecondsSinceEpoch;
    late int dd = d.day - 1;
    late int re = ((d0 - d1) / 8.64e7).floor() + (dd > 0 ? dd - 1 : 6);
    late String result =
        ((re / 7) % 2).floor() != 0 ? 'Верхняя неделя' : 'Нижняя неделя';
    return result;
  }

  WeekType getWeekType(){
    final result = _getWeekString();
    return result == 'Верхняя неделя'? WeekType.upper: WeekType.lower;
  }
  @override
  Widget build(BuildContext context) {
    final result = _getWeekString();
    // в зависимости от переданной даты, возвращается текст "неделя" - верхняя или нижняя
    return Text(
      result,
      style: textStyle,
    );
  }
}
