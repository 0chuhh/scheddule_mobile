import 'package:flutter/material.dart';
import 'package:schedule_mobile/utils/months_localizaition.dart';
import 'package:schedule_mobile/themes/styles.dart';
import 'package:schedule_mobile/widgets/collapsible_calendar/base_calendar.dart';
import 'package:schedule_mobile/widgets/collapsible_calendar/calendar_animated_container.dart';
import 'package:schedule_mobile/widgets/collapsible_calendar/calendar_collapse-button.dart';
import 'package:schedule_mobile/widgets/week.dart';
import 'package:table_calendar/table_calendar.dart';

/// `OnDayChanged` - функция, которая выполнится после смены текущего дня на другой.
typedef OnDayChanged = void Function(DateTime selectedDay);

/// `OnFormatChanged` - функция, которая вызовется после смены формата календаря.
typedef OnFormatChanged = void Function(CalendarFormat format);

class CollapsibleCalendar extends StatefulWidget {
  const CollapsibleCalendar(
      {this.align = Alignment.topCenter,
      this.onDayChanged,
      this.onFormatChanged,
      super.key});

  final OnDayChanged? onDayChanged;

  final OnFormatChanged? onFormatChanged;

  final Alignment align;

  @override
  State<StatefulWidget> createState() {
    return CollapsibleCalendarState();
  }
}

class CollapsibleCalendarState extends State<CollapsibleCalendar> {
  DateTime _selectedDay = DateTime.now();

  final DateTime _focusedDay = DateTime.now();

  bool _headerVisible = false;

  final TextStyle _weekStyle =
      TextStyle(fontSize: 12, color: Styles.primaryColor);

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

    widget.onDayChanged?.call(day);
  }

  void changeFormat() {
    setState(() {
      if (_format == CalendarFormat.month) {
        _format = CalendarFormat.week;
        _headerVisible = false;
      } else {
        _format = CalendarFormat.month;
        setState(() {
          _headerVisible = true;
        });
      }
    });

    widget.onFormatChanged?.call(_format);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: widget.align,
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              child:
                  CalendarAnimatedContainer(format: _format, children: <Widget>[
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
              ]),
            ),
          ],
        ));
  }
}
