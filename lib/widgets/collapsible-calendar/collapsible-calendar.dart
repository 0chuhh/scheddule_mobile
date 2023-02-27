import 'package:flutter/material.dart';
import 'package:schedule_mobile/utils/months-localizaition.dart';
import 'package:schedule_mobile/widgets/collapsible-calendar/base-calendar.dart';
import 'package:schedule_mobile/widgets/collapsible-calendar/calendar-animated-container.dart';
import 'package:schedule_mobile/widgets/collapsible-calendar/calendar-collapse-button.dart';
import 'package:schedule_mobile/widgets/week.dart';
import 'package:table_calendar/table_calendar.dart';

class CollapsibleCalendar extends StatefulWidget {
  const CollapsibleCalendar({this.align = Alignment.topCenter, super.key});
  final Alignment align;

  @override
  State<StatefulWidget> createState() {
    return _CollapsibleCalendarState();
  }
}

class _CollapsibleCalendarState extends State<CollapsibleCalendar> {
  DateTime _selectedDay = DateTime.now();

  final DateTime _focusedDay = DateTime.now();

  bool _headerVisible = false;

  final TextStyle _weekStyle =
      const TextStyle(fontSize: 12, color: Color.fromRGBO(96, 109, 224, 1));

  late Week _week = Week(
    date: DateTime.now(),
    textStyle: _weekStyle,
  );

  late String _monthName = getMonthName(DateTime.now().month - 1);

  CalendarFormat _format = CalendarFormat.week;

  void changeDay(DateTime day) {
    setState(() {
      _selectedDay = day;
      _monthName = getMonthName(day.month - 1);
      _week = Week(
        date: day,
        textStyle: _weekStyle,
      );
    });
  }

  void changeFormat() {
    setState(() {
      if (_format == CalendarFormat.month) {
        _format = CalendarFormat.week;
        _headerVisible = false;
      } else {
        _format = CalendarFormat.month;
        var future = Future.delayed(const Duration(milliseconds: 100), () {
          setState(() {
            _headerVisible = true;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: widget.align,
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            SizedBox(
              width: 350,
              child: CalendarAnimatedContainer(
                format: _format,
                child: SingleChildScrollView(
                    child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    BaseCalendar(changeFormat, _selectedDay, changeDay, _format,
                        _headerVisible),
                    Positioned(
                        bottom: 0,
                        child: CalendarCollapseButton(
                          changeFormat: changeFormat,
                          monthName: _monthName,
                          selectedDay: _selectedDay,
                          week: _week,
                          format: _format,
                        ))
                  ],
                )),
              ),
            ),
          ],
        ));
  }
}
