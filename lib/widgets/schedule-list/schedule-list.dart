import 'package:flutter/material.dart';
import 'package:schedule_mobile/widgets/schedule-list/schedule-list-item.dart';
import 'package:timelines/timelines.dart';

final List<ScheduleItem> schedule = [
  ScheduleItem(couple: Couple(number: 1, time: DateTime.now()), name: 'Администрирование и конфигурирование системы 1С:Предприятия', lecturer: 'Иванов Александр Владимирович')
];


class Couple {
  int ? number;
  DateTime ? time;

  Couple({this.number, this.time});
}


class ScheduleItem {
  Couple ? couple;
  String ? name;
  String ? lecturer;
  String ? cathedra;
  String ? classroom;

  ScheduleItem({this.couple, this.name, this.lecturer, this.cathedra, this.classroom });
}

class ScheduleList extends StatelessWidget {
  List<String> schedule = ['1', '2', '3', '4', '5', '6,', '7', '8', '9', '10'];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 1,
      child: Expanded(
          flex: 1,
          child: Timeline.tileBuilder(
            builder: TimelineTileBuilder(
              nodePositionBuilder: (context, index) => 0.14,
              oppositeContentsBuilder: (context, index) => TimelineNode(
                indicator: Text('10:50'),
                startConnector: index == 0? null : const DashedLineConnector(),
                endConnector: index == schedule.length? null : const DashedLineConnector(),
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
          )),
    );
  }
}
