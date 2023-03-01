import 'package:flutter/material.dart';
import 'package:schedule_mobile/models/schedule.dart';
import 'package:schedule_mobile/utils/styles.dart';

class ScheduleListItem extends StatelessWidget {
  ScheduleListItem({super.key, required this.item});

  final ScheduleItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(7))
      ),
      width: 800,
      height: 300,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                alignment: Alignment.center,
                width: 30,
                decoration: BoxDecoration(
                  color: Styles.primaryColor,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))
                ),
                child: Text(item.couple!.number.toString(), style: TextStyle(color: Colors.white),)
              )
            ],
            )
        ]
        ),
    );
  }
}
