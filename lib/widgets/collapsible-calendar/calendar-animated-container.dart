import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarAnimatedContainer extends StatelessWidget {
  const CalendarAnimatedContainer({required this.format, required this.child, super.key});

  final CalendarFormat format;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
                  padding: const EdgeInsets.all(10),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  curve: Curves.easeOutBack,
                  duration: Duration(
                      milliseconds:
                          format == CalendarFormat.month ? 500 : 400),
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
                  height: format == CalendarFormat.week ? 80 : 355,
                  margin: const EdgeInsets.only(top: 20),
                  child: child
                  
                  // SingleChildScrollView(
                  //     child: Column(
                  //   children: <Widget>[
                  //     SingleChildScrollView(
                  //         child: Expanded(
                  //             flex: 0,
                  //             child: SizedBox(
                  //               child: MyCalendar(changeFormat, _selectedDay,
                  //                   changeDay, _format, _headerVisible),
                  //             ))),
                  //     ExpandCalendarButton(changeFormat, _format, _monthName,
                  //         _selectedDay, _week)
                  //   ],
                  // ))
                  );
  }
}