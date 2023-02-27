import 'package:flutter/material.dart';
import 'package:schedule_mobile/widgets/week.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarCollapseButton extends StatelessWidget {
  const CalendarCollapseButton(
      {super.key,
      required this.changeFormat,
      required this.monthName,
      required this.selectedDay,
      required this.week,
      required this.format});
  final VoidCallback changeFormat;
  final DateTime selectedDay;
  final String monthName;
  final Week week;
  final CalendarFormat format;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: changeFormat,
        onHorizontalDragEnd: (details) => changeFormat(),
        onVerticalDragEnd: (details) => changeFormat(),
        child: ClipPath(
          child: Container(
            height: 20,
            color: Colors.transparent,
            child: Row(
              children: <Widget>[
                Text(
                  '${selectedDay.day} $monthName ',
                  style: const TextStyle(
                      fontSize: 12, color: Color.fromRGBO(96, 109, 224, 1)),
                ),
                week,
                Icon(
                  format == CalendarFormat.week
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_up,
                  color: const Color.fromRGBO(96, 109, 224, 1),
                  size: 15,
                )
              ],
            ),
          ),
        ));
  }
}
