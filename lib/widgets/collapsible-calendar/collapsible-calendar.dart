import 'package:flutter/material.dart';
import 'package:schedule_mobile/utils/months-localizaition.dart';
import 'package:schedule_mobile/widgets/collapsible-calendar/base-calendar.dart';
import 'package:schedule_mobile/widgets/collapsible-calendar/calendar-animated-container.dart';
import 'package:schedule_mobile/widgets/week.dart';
import 'package:table_calendar/table_calendar.dart';

class CollapsibleCalendar extends StatefulWidget {
  const CollapsibleCalendar({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CollapsibleCalendarState();
  }
}

class _CollapsibleCalendarState extends State<CollapsibleCalendar> {

  DateTime _selectedDay = DateTime.now();

  DateTime _focusedDay = DateTime.now();

  bool _headerVisible = false;

  Week _week = Week(DateTime.now());

  late String _monthName = getMonthName(DateTime.now().month - 1);

  CalendarFormat _format = CalendarFormat.month;


  

  void changeDay(DateTime day) {
    setState(() {
      _selectedDay = day;
      _monthName = getMonthName(day.month - 1);
      _week = Week(day);
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
    return Stack(
      children: <Widget> [
        SizedBox(
          width: 350,
          child: CalendarAnimatedContainer(
            format: _format,
            child: SingleChildScrollView(child:BaseCalendar(changeFormat, _selectedDay, changeDay, _format, _headerVisible)),
          ),
        )
      ],
    );
    
  }
}
