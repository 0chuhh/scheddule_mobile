import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schedule_mobile/widgets/collapsible_calendar/collapsible_calendar.dart';
import 'package:schedule_mobile/widgets/app_bar_painter.dart';
import 'package:schedule_mobile/widgets/schedule_list/schedule_list.dart';

import '../utils/styles.dart';

class MyScheduleScreen extends StatelessWidget {
  const MyScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      extendBodyBehindAppBar: true,
      body: Column(children: <Widget>[
        Stack(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 170),
            child:  ScheduleList(),
          ),
          CustomPaint(
            painter: AppBarPainter(),
            child: Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              height: 200,
            ),
          ),
          CollapsibleCalendar(),
        ]),
      ]),
    );
  }
}
