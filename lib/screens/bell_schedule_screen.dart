import 'package:flutter/material.dart';

import '../utils/styles.dart';
import '../widgets/app_bar_painter.dart';
import '../widgets/collapsible_calendar/collapsible_calendar.dart';
import '../widgets/schedule_list/schedule_list.dart';

class BellScheduleScreen extends StatelessWidget {
  const BellScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      extendBodyBehindAppBar: true,
      body: Stack(children:<Widget>[
        ScheduleList(),

        CustomPaint(
          painter: AppBarPainter(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
          ),
        ),
        CollapsibleCalendar(),
      ]),
    );
  }
}
