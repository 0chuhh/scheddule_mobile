import 'package:flutter/material.dart';
import 'package:schedule_mobile/models/schedule.dart';
import 'package:schedule_mobile/utils/styles.dart';

class ScheduleListItem extends StatelessWidget {
  const ScheduleListItem({super.key, required this.item});

  final ScheduleItem item;

  String getFormatName(ScheduleItemFormat? format) {
    switch (format) {
      case ScheduleItemFormat.lection:
        return 'Лекция';
      case ScheduleItemFormat.practice:
        return 'Практика';
      case ScheduleItemFormat.laboratory:
        return 'Лабораторная';
      default:
        return 'Лекция';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(7))),
      width: 800,
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    width: 30,
                    decoration: BoxDecoration(
                        color: Styles.primaryColor,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: Text(
                      item.couple.number.toString(),
                      style: const TextStyle(color: Colors.white),
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    getFormatName(item.format),
                    style: const TextStyle(color: Color.fromRGBO(148, 163, 184, 1)),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Text(
                item.name,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
              child: Text(item.lecturer),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Каф.${item.cathedra}'),
                  Text(item.classroom),
                ],
              ),
            ),
          ]),
    );
  }
}
