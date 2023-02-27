import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class BaseCalendar extends StatelessWidget {
  const BaseCalendar(this.changeFormat, this.selectedDay, this.changeDay, this.format,
      this.headerVisible,
      {super.key});

  final Function(DateTime day) changeDay;

  final DateTime selectedDay;
  
  final CalendarFormat format;
  
  final VoidCallback changeFormat;
  
  final bool headerVisible;
  
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
        // locale: 'ru_RU',
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        calendarFormat: format,
        startingDayOfWeek: StartingDayOfWeek.monday,
        availableCalendarFormats: const {
          CalendarFormat.month: 'month',
          CalendarFormat.week: 'week'
        },
        headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            titleTextStyle: TextStyle(color: Color.fromRGBO(148, 163, 184, 1))),
        formatAnimationCurve: Curves.ease,
        formatAnimationDuration:
            Duration(milliseconds: format == CalendarFormat.month ? 400 : 200),
        headerVisible: headerVisible,
        focusedDay: selectedDay,
        daysOfWeekStyle: const DaysOfWeekStyle(
            weekdayStyle: TextStyle(color: Color.fromRGBO(148, 163, 184, 1)),
            weekendStyle: TextStyle(color: Color.fromRGBO(148, 163, 184, 1))),
        calendarStyle: CalendarStyle(
            weekendTextStyle:
                const TextStyle(color: Color.fromRGBO(251, 173, 57, 1)),
            todayTextStyle:
                const TextStyle(color: Color.fromRGBO(251, 173, 57, 1)),
            selectedDecoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromRGBO(251, 173, 57, 1),
            ),
            todayDecoration: const BoxDecoration(
                color: Colors.transparent, shape: BoxShape.circle),
            tableBorder: TableBorder.all(
                color: Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(50)))),
        onFormatChanged: (format) {
          changeFormat();
        },
        selectedDayPredicate: (day) => isSameDay(day, selectedDay),
        onDaySelected: (selectedDay, focusedDay) {
          changeDay(selectedDay);
        });
  }
}
