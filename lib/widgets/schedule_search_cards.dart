import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schedule_mobile/utils/styles.dart';
import 'package:schedule_mobile/widgets/custom_autocomplete.dart';
import 'package:schedule_mobile/widgets/custom_button_group.dart';

class ScheduleSearchCards extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScheduleSearchCardsState();
  }
}

class _ScheduleSearchCardsState extends State<ScheduleSearchCards> {
  final bool fullTimeFormat = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 15),
      height: MediaQuery.of(context).size.height - 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            width: MediaQuery.of(context).size.width - 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Найти расписание занятий по группе:',
                  style: TextStyle(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left,
                ),
                const Gap(5),
                const CustomAutocomplete(
                    list: ['пи-20', 'пи-21', 'пи-22'], label: 'группа'),
                const Gap(5),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    backgroundColor: Styles.primaryColor,
                    minimumSize: const Size.fromHeight(
                        30), // fromHeight use double.infinity as width and 40 is the height
                  ),
                  child: const Text('Найти'),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            width: MediaQuery.of(context).size.width - 20,
            child: Column(
              children: <Widget>[
                const Text(
                  'Найти расписание занятий по преподавателю:',
                  style: TextStyle(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left,
                ),
                const Gap(5),
                const CustomAutocomplete(
                    list: ['пи-20', 'пи-21', 'пи-22'], label: 'Преподаватель'),
                const Gap(5),
                CustomButtonGroup(
                  items: [
                    Text('Очная форма'),
                    Text('Заочная форма'),
                  ],
                ),
                const Gap(5),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    backgroundColor: Styles.primaryColor,
                    minimumSize: const Size.fromHeight(30),
                    padding: EdgeInsets.zero,
                  ),
                  child: const Text('Найти'),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            width: MediaQuery.of(context).size.width - 20,
            child: Column(
              children: <Widget>[
                const Text(
                  'Найти расписание занятий по аудитории:',
                  style: TextStyle(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left,
                ),
                const Gap(5),
                const CustomAutocomplete(
                    list: ['пи-20', 'пи-21', 'пи-22'], label: 'аудитория'),
                const Gap(5),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    backgroundColor: Styles.primaryColor,
                    minimumSize: const Size.fromHeight(
                        30), // fromHeight use double.infinity as width and 40 is the height
                  ),
                  child: const Text('Найти'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
