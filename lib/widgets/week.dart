import 'package:flutter/material.dart';

class Week extends StatelessWidget {
  const Week(this.date, {super.key});
  final DateTime date;
  
  @override
  Widget build(BuildContext context) {
    late DateTime d = DateTime(date.year, 1, 1);
    late int d0 = date.millisecondsSinceEpoch;
    late int d1 = d.millisecondsSinceEpoch;
    late int dd = d.day-1;
    late int re = ((d0 - d1) / 8.64e7).floor()  + (dd > 0 ? dd - 1 : 6);
    late String result = ((re/7)%2).floor() != 0 ? 'Верхняя неделя' : 'Нижняя неделя';
    // в зависимости от переданной даты, возвращается текст "неделя" - верхняя или нижняя
    return Text(result); 
  }
}