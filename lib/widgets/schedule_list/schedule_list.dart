import 'package:flutter/material.dart';
import 'package:schedule_mobile/widgets/schedule_list/schedule_list_item.dart';
import 'package:timelines/timelines.dart';
import 'package:intl/intl.dart';
import '../../models/schedule_model.dart';

class ScheduleList extends StatelessWidget {
  const ScheduleList({super.key, this.schedule = const []});

  final List<ScheduleModel> schedule;
  String getCoupleTime(DateTime date) {
    return DateFormat.Hm().format(date);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Container(
      padding: const EdgeInsets.only(top: 250),
      child: Timeline.tileBuilder(
        padding: const EdgeInsets.only(top: 20),
        builder: TimelineTileBuilder(
          nodePositionBuilder: (context, index) => 0.14,
          oppositeContentsBuilder: (context, index) => TimelineNode(
            indicator: Text(getCoupleTime(schedule[index].couple.time)),
            startConnector: index == 0 ? null : const DashedLineConnector(),
            endConnector: index == schedule.length - 1
                ? null
                : const DashedLineConnector(),
          ),
          contentsBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 24, bottom: 24),
              child: ScheduleListItem(
                item: schedule[index],
              )),
          itemCount: schedule.length,
        ),
        shrinkWrap: true,
        theme: TimelineThemeData(
          connectorTheme: const ConnectorThemeData(indent: 5),
        ),
      ),
    ));
  }
}
