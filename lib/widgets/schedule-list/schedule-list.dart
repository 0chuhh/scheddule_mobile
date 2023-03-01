import 'package:flutter/material.dart';
import 'package:schedule_mobile/widgets/schedule-list/schedule-list-item.dart';
import 'package:timelines/timelines.dart';

import '../../models/schedule.dart';




class ScheduleList extends StatelessWidget {
final List<ScheduleItem> schedule = [
  ScheduleItem(
      couple: Couple(number: 1, time: DateTime.now()),
      name: 'Администрирование и конфигурирование системы 1С:Предприятия',
      lecturer: 'Иванов Александр Владимирович',
      cathedra: 'ПиМ',
      classroom: '03-401'),
  ScheduleItem(
      couple: Couple(number: 2, time: DateTime.now()),
      name: 'Администрирование и конфигурирование системы 1С:Предприятия',
      lecturer: 'Иванов Александр Владимирович',
      cathedra: 'ПиМ',
      classroom: '03-401'),
  ScheduleItem(
      couple: Couple(number: 3, time: DateTime.now()),
      name: 'Администрирование и конфигурирование системы 1С:Предприятия',
      lecturer: 'Иванов Александр Владимирович',
      cathedra: 'ПиМ',
      classroom: '03-401')
];
 void hello(){
print(schedule[0].couple?.time);
}

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Expanded(
          flex: 1,
          child: Timeline.tileBuilder(
            builder: TimelineTileBuilder(
              nodePositionBuilder: (context, index) => 0.14,
              oppositeContentsBuilder: (context, index) => TimelineNode(
                indicator: Text('10:50'),
                startConnector: index == 0 ? null : const DashedLineConnector(),
                endConnector: index == schedule.length
                    ? null
                    : const DashedLineConnector(),
              ),
              contentsBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ScheduleListItem(
                    item: schedule[index],
                  )),
              itemCount: schedule.length,
            ),
            shrinkWrap: true,
            theme: TimelineThemeData(
              connectorTheme: ConnectorThemeData(indent: 5),
            ),
          ))
    );
  }
}
