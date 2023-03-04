import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schedule_mobile/utils/styles.dart';
import 'package:schedule_mobile/widgets/custom_autocomplete.dart';
import 'package:schedule_mobile/widgets/custom_button_group.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ScheduleSearchCards extends StatefulWidget {
  const ScheduleSearchCards({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ScheduleSearchCardsState();
  }
}

class _ScheduleSearchCardsState extends State<ScheduleSearchCards> {
  final bool fullTimeFormat = false;
  int selectedIndex = 0;
  void onAutocompleteTap(int index) {
    setState(() {
      selectedIndex = 0;
      selectedIndex = index;
    });
  }

  void unfocusAutocomplete() {
    setState(() {
      selectedIndex = 0;
    });

    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.only(top: 15),
      height: MediaQuery.of(context).size.height - 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AnimatedContainer(
            curve: Curves.easeInBack,
            duration: const Duration(milliseconds: 700),
            transform: Matrix4.compose(
                vector.Vector3(
                    0,
                    selectedIndex == 1
                        ? MediaQuery.of(context).size.height / 3.7
                        : selectedIndex == 2
                            ? MediaQuery.of(context).size.height / 2
                            : 0,
                    0),
                vector.Quaternion(0, 0, 0, 0),
                vector.Vector3(1, 1, 1)),
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
                CustomAutocomplete(
                    list: const ['пи-20', 'пи-21', 'пи-22'],
                    label: 'группа',
                    onTap: (focusNode) {
                      onAutocompleteTap(0);
                    },
                    onTapOutside: () {}),
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
          AnimatedContainer(
            curve: Curves.easeInBack,
            duration: const Duration(milliseconds: 700),
            transform: Matrix4.compose(
                vector.Vector3(
                    0,
                    selectedIndex == 1
                        ? -MediaQuery.of(context).size.height / 4
                        : 0,
                    0),
                vector.Quaternion(0, 0, 0, 0),
                vector.Vector3(1, 1, 1)),
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
                CustomAutocomplete(
                  list: const ['пи-20', 'пи-21', 'пи-22'],
                  label: 'Преподаватель',
                  onTap: (focusNode) {
                    onAutocompleteTap(1);
                    FocusScope.of(context).requestFocus(focusNode);
                  },
                  onTapOutside: () {
                    unfocusAutocomplete();
                  },
                ),
                const Gap(5),
                const CustomButtonGroup(
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
          AnimatedContainer(
            curve: Curves.easeInBack,
            transform: Matrix4.compose(
                vector.Vector3(
                    0,
                    selectedIndex == 2
                        ? -MediaQuery.of(context).size.height * 0.54
                        : 0,
                    0),
                vector.Quaternion(0, 0, 0, 0),
                vector.Vector3(1, 1, 1)),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            width: MediaQuery.of(context).size.width - 20,
            duration: const Duration(milliseconds: 700),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Найти расписание занятий по аудитории:',
                  style: TextStyle(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left,
                ),
                const Gap(5),
                CustomAutocomplete(
                  list: const [],
                  label: 'Аудитория',
                  onTap: (focusNode) {
                    onAutocompleteTap(2);
                    FocusScope.of(context).requestFocus(focusNode);
                  },
                  onTapOutside: () {
                    unfocusAutocomplete();
                  },
                ),
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
