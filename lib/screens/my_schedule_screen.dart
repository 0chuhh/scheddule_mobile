import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:schedule_mobile/models/schedule.dart';
import 'package:schedule_mobile/repositories/schedule.dart';
import 'package:schedule_mobile/widgets/collapsible_calendar/collapsible_calendar.dart';
import 'package:schedule_mobile/widgets/app_bar_painter.dart';
import 'package:schedule_mobile/widgets/schedule_list/schedule_list.dart';
import 'package:schedule_mobile/widgets/week.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import '../utils/styles.dart';
import '../widgets/next_lesson.dart';

class MyScheduleScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyScheduleScreenState();
  }
}

class _MyScheduleScreenState extends State<MyScheduleScreen> {
  final List<ScheduleItem> schedule = ScheduleRepository().getScheduleByGroup();

  List<ScheduleItem> daySchedule = [];

  @override
  void initState() {
    daySchedule = schedule
        .where((element) =>
            element.weekDay == DateTime.now().weekday - 1 &&
            element.weekType == Week(date: DateTime.now()).getWeekType())
        .toList();
    print(daySchedule);
    super.initState();
  }

  void dayChanged(DateTime day) {
    setState(() {
      WeekType currentWeek = Week(date: day).getWeekType();
      daySchedule = schedule
          .where((element) =>
              element.weekDay == day.weekday - 1 &&
              element.weekType == currentWeek)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Styles.bgColor,
      extendBodyBehindAppBar: true,
      body: Stack(children: <Widget>[
        Positioned.fill(
            child: daySchedule.length > 0
                ? ScheduleList(
                    schedule: daySchedule,
                  )
                : Container(
                    margin: EdgeInsets.only(top: 150),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Сегодня у вас нет занятий. Советуем потратить это время на самоподготовку.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFF9498BE),
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          ),
                          SvgPicture.asset(
                            'assets/noLessons.svg',
                            width: 270,
                          )
                        ]),
                  )),
        Stack(children: <Widget>[
          CustomPaint(
            painter: AppBarPainter(),
            child: Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              height: 260,
              child: NextLesson(),
            ),
          ),
          CollapsibleCalendar(
            onDayChanged: (selectedDay) {
              dayChanged(selectedDay);
            },
          ),
        ])
      ]),
    );
  }
}
