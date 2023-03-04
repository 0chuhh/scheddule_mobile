import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schedule_mobile/widgets/collapsible_calendar/collapsible_calendar.dart';
import 'package:schedule_mobile/widgets/app_bar_painter.dart';
import 'package:schedule_mobile/widgets/schedule_list/schedule_list.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import '../utils/styles.dart';
import '../widgets/next_lesson.dart';

class MyScheduleScreen extends StatelessWidget {
  const MyScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Styles.bgColor,
      extendBodyBehindAppBar: true,
      body: Stack(children: <Widget>[
        Positioned.fill(child: ScheduleList()),
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
          CollapsibleCalendar(),
        ])
      ]),
    );
  }
}
