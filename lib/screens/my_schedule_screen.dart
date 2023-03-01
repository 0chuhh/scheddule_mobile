import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schedule_mobile/widgets/collapsible-calendar/collapsible-calendar.dart';
import 'package:schedule_mobile/widgets/custom_app_bar.dart';
import 'package:schedule_mobile/widgets/schedule-list/schedule-list.dart';

import '../utils/styles.dart';

class MyScheduleScreen extends StatelessWidget {
  const MyScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(
        body: CollapsibleCalendar(),
        height: 200,
      ),
      body: ScheduleList(),
    );
  }
}
