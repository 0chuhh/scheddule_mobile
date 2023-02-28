import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schedule_mobile/widgets/collapsible-calendar/collapsible-calendar.dart';
import 'package:schedule_mobile/widgets/schedule-list/schedule-list.dart';

class MyScheduleScreen extends StatelessWidget {
  const MyScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        ScheduleList(),
        const CollapsibleCalendar(),

      ],
    );
  }
}
