import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schedule_mobile/widgets/collapsible_calendar/collapsible_calendar.dart';
import 'package:schedule_mobile/widgets/app_bar_painter.dart';
import 'package:schedule_mobile/widgets/schedule_list/schedule_list.dart';

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
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Stack(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 230),
              child: ScheduleList(),
            ),
            CustomPaint(
              painter: AppBarPainter(),
              child: Container(
                alignment: Alignment.bottomCenter,
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width,
                height: 260,
                child: NextLesson(),
              ),
            ),
            CollapsibleCalendar(),
          ]),
        ]),
      ),
    );
  }
}
