import 'package:flutter/material.dart';
import 'package:schedule_mobile/widgets/schedule_list/schedule_list_item.dart';
import 'package:timelines/timelines.dart';
import 'package:intl/intl.dart';
import '../../models/schedule.dart';

class ScheduleList extends StatelessWidget {
  final List<ScheduleItem> schedule = [
    ScheduleItem(
        couple: Couple(number: 1, time: DateTime(2023, 1, 1, 8, 30)),
        name: 'Администрирование и конфигурирование системы 1С:Предприятия',
        lecturer: 'Иванов Александр Владимирович',
        cathedra: 'ПиМ',
        classroom: '03-401',
        format: ScheduleItemFormat.lection),
    ScheduleItem(
        couple: Couple(number: 2, time: DateTime(2023, 1, 1, 10, 15)),
        name: 'Администрирование и конфигурирование системы 1С:Предприятия',
        lecturer: 'Иванов Александр Владимирович',
        cathedra: 'ПиМ',
        classroom: '03-401',
        format: ScheduleItemFormat.practice),
    ScheduleItem(
        couple: Couple(number: 3, time: DateTime(2023, 1, 1, 12, 00)),
        name: 'Администрирование и конфигурирование системы 1С:Предприятия',
        lecturer: 'Иванов Александр Владимирович',
        cathedra: 'ПиМ',
        classroom: '03-401',
        format: ScheduleItemFormat.laboratory),
    ScheduleItem(
        couple: Couple(number: 4, time: DateTime(2023, 1, 1, 14, 35)),
        name: 'Администрирование и конфигурирование системы 1С:Предприятия',
        lecturer: 'Иванов Александр Владимирович',
        cathedra: 'ПиМ',
        classroom: '03-401',
        format: ScheduleItemFormat.laboratory),
    ScheduleItem(
        couple: Couple(number: 5, time: DateTime(2023, 1, 1, 16, 20)),
        name: 'Администрирование и конфигурирование системы 1С:Предприятия',
        lecturer: 'Иванов Александр Владимирович',
        cathedra: 'ПиМ',
        classroom: '03-401',
        format: ScheduleItemFormat.laboratory)
  ];

  String getCoupleTime(DateTime date) {
    return DateFormat.Hm().format(date);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Expanded(
            flex: 1,
            child: Timeline.tileBuilder(
              builder: TimelineTileBuilder(
                nodePositionBuilder: (context, index) => 0.14,
                oppositeContentsBuilder: (context, index) => TimelineNode(
                  indicator: Text(getCoupleTime(schedule[index].couple.time)),
                  startConnector:
                      index == 0 ? null : const DashedLineConnector(),
                  endConnector: index == schedule.length - 1
                      ? null
                      : const DashedLineConnector(),
                ),
                contentsBuilder: (context, index) => Padding(
                    padding:
                        const EdgeInsets.only(left: 5.0, right: 24, bottom: 24),
                    child: ScheduleListItem(
                      item: schedule[index],
                    )),
                itemCount: schedule.length,
              ),
              shrinkWrap: true,
              theme: TimelineThemeData(
                connectorTheme: ConnectorThemeData(indent: 5),
              ),
            )));
  }
}
