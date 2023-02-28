import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarAnimatedContainer extends StatelessWidget {
  const CalendarAnimatedContainer(
      {required this.format, required this.children, super.key});

  final CalendarFormat format;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        curve: Curves.easeOutBack,
        duration:
            Duration(milliseconds: format == CalendarFormat.month ? 500 : 400),
        decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: Offset(1, 5),
                spreadRadius: 3,
                blurRadius: 9,
                color: Color.fromRGBO(200, 202, 224, 1),
              )
            ],
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(50))),
        height: format == CalendarFormat.week ? 80 : 350,
        margin: const EdgeInsets.only(top: 40),
        child: SingleChildScrollView(
            child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomCenter,
                children: children)));
  }
}
