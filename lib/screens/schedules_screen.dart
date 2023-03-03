import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schedule_mobile/widgets/custom_autocomplete.dart';

import '../utils/styles.dart';
import '../widgets/app_bar_painter.dart';
import '../widgets/collapsible_calendar/collapsible_calendar.dart';
import '../widgets/schedule_list/schedule_list.dart';
import '../widgets/schedule_search_cards.dart';

class SchedulesScreen extends StatelessWidget {
  const SchedulesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      extendBodyBehindAppBar: true,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
        Stack(children: <Widget>[
          CustomPaint(
            painter: AppBarPainter(),
            child: Container(
              margin: EdgeInsets.only(top: 40),
              width: MediaQuery.of(context).size.width,
              height: 70,
              child: const Text(
                'Расписание по фильтрам',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xFF979CB7),
                    fontSize: 20,
                    fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ]),
        ScheduleSearchCards()
      ]),
    );
  }
}
