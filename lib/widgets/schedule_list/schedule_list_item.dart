import 'package:flutter/material.dart';
import 'package:flutter_theme_provider/flutter_theme_provider.dart';
import 'package:schedule_mobile/models/schedule_model.dart';
import 'package:schedule_mobile/screens/my_schedule_screen.dart';
import 'package:schedule_mobile/themes/styles.dart';
import 'package:provider/provider.dart';

class ScheduleListItem extends StatelessWidget {
  const ScheduleListItem(
      {super.key,
      required this.item,
      this.screenType = ScheduleScreenType.mySchedule});

  final ScheduleModel item;
  final ScheduleScreenType screenType;
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
    return Consumer<ThemeProvider>(
        builder: (context, theme, child) => Container(
              decoration: BoxDecoration(
                  color: theme.getThemeName() == 'Light'
                      ? Colors.white
                      : const Color(0xFF3D3D3D),
                  borderRadius: const BorderRadius.all(Radius.circular(7))),
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
                            style: const TextStyle(
                                color: Color.fromRGBO(148, 163, 184, 1)),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Text(
                        item.name,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 5),
                      child: Text(
                          screenType == ScheduleScreenType.lecturerSchedule &&
                                  item.group != null
                              ? item.group!
                              : item.lecturer),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Каф.${item.cathedra}'),
                          Text(item.group != null &&
                                  screenType ==
                                      ScheduleScreenType.classroomSchedule
                              ? item.group!
                              : item.classroom),
                        ],
                      ),
                    ),
                  ]),
            ));
  }
}
