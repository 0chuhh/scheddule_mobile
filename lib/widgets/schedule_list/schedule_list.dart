import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:schedule_mobile/screens/my_schedule_screen.dart';
import 'package:schedule_mobile/themes/styles.dart';
import 'package:schedule_mobile/utils/get_date_from_extremular.dart';
import 'package:schedule_mobile/widgets/schedule_list/schedule_list_item.dart';
import 'package:timelines/timelines.dart';
import '../../models/schedule_model.dart';

class ScheduleList extends StatelessWidget {
  const ScheduleList(
      {super.key,
      this.schedule = const [],
      this.padding = 250,
      this.screenType = ScheduleScreenType.mySchedule});
  final double padding;
  final ScheduleScreenType screenType;
  final List<ScheduleModel> schedule;
  String getCoupleTime(DateTime date) {
    return DateFormat.Hm().format(date);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Container(
      padding: EdgeInsets.only(top: padding),
      child: Timeline.tileBuilder(
        padding: const EdgeInsets.only(top: 20),
        builder: TimelineTileBuilder(
          nodePositionBuilder: (context, index) =>
              schedule[index].form == '0' ? 0.14 : 0.20,
          oppositeContentsBuilder: (context, index) => TimelineNode(
            indicator: Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  getCoupleTime(schedule[index].couple.time),
                  style: TextStyle(color: Styles.primaryColor),
                )),
            startConnector: index == 0
                ? null
                : DashedLineConnector(
                    color: Styles.primaryColor,
                    thickness: 1.5,
                  ),
            endConnector: index == schedule.length - 1
                ? null
                : DashedLineConnector(
                    color: Styles.primaryColor,
                    thickness: 1.5,
                  ),
          ),
          contentsBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 24, bottom: 24),
              child: ScheduleListItem(
                screenType: screenType,
                item: schedule[index],
              )),
          itemCount: schedule.length,
        ),
        shrinkWrap: true,
      ),
    ));
  }
}
