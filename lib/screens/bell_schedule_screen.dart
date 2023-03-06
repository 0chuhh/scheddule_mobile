import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:timelines/timelines.dart';

import '../utils/styles.dart';
import '../widgets/app_bar_painter.dart';

class BellScheduleScreen extends StatefulWidget {
  const BellScheduleScreen({Key? key}) : super(key: key);

  @override
  State<BellScheduleScreen> createState() => _BellScheduleScreenState();
}

class _BellScheduleScreenState extends State<BellScheduleScreen> {
  final List<Map<String, dynamic>> _allFaculties = [
    {
      'id': 1,
      'name': 'Факультет строительства и экологии',
      'bellSchedule': {
        'big_break': '13:35 - 14:35',
        '1': '08:30 - 10:05',
        '2': '10:15 - 11:50',
        '3': '12:00 - 13:35',
        '4': '14:35 - 16:10',
        '5': '16:20 - 17:55',
        '6': '18:05 - 19:40',
      }
    },
    {
      'id': 2,
      'name': 'Факультет экономики и управления',
      'bellSchedule': {
        'big_break': '13:35 - 14:35',
        '1': '08:30 - 10:05',
        '2': '10:15 - 11:50',
        '3': '12:00 - 13:35',
        '4': '14:35 - 16:10',
        '5': '16:20 - 17:55',
        '6': '18:05 - 19:40',
      }
    },
    {
      'id': 3,
      'name': 'Энергетический факультет',
      'bellSchedule': {
        'big_break': '13:35 - 14:35',
        '1': '08:30 - 10:05',
        '2': '10:15 - 11:50',
        '3': '12:00 - 13:35',
        '4': '14:35 - 16:10',
        '5': '16:20 - 17:55',
        '6': '18:05 - 19:40',
      }
    },
    {
      'id': 4,
      'name': 'Горный факультет',
      'bellSchedule': {
        'big_break': '13:35 - 14:35',
        '1': '08:30 - 10:05',
        '2': '10:15 - 11:50',
        '3': '12:00 - 13:35',
        '4': '14:35 - 16:10',
        '5': '16:20 - 17:55',
        '6': '18:05 - 19:40',
      }
    },
    {
      'id': 5,
      'name': 'Историко-филологический факультет',
      'bellSchedule': {
        'big_break': '13:35 - 14:35',
        '1': '08:30 - 10:05',
        '2': '10:15 - 11:50',
        '3': '12:00 - 13:35',
        '4': '14:35 - 16:10',
        '5': '16:20 - 17:55',
        '6': '18:05 - 19:40',
      }
    },
    {
      'id': 6,
      'name': 'Факультет культуры и искусств',
      'bellSchedule': {
        'big_break': '13:35 - 14:35',
        '1': '08:30 - 10:05',
        '2': '10:15 - 11:50',
        '3': '12:00 - 13:35',
        '4': '14:35 - 16:10',
        '5': '16:20 - 17:55',
        '6': '18:05 - 19:40',
      }
    },
    {
      'id': 7,
      'name': 'Факультет физической культуры и спорта',
      'bellSchedule': {
        'big_break': '13:35 - 14:35',
        '1': '08:30 - 10:05',
        '2': '10:15 - 11:50',
        '3': '12:00 - 13:35',
        '4': '14:35 - 16:10',
        '5': '16:20 - 17:55',
        '6': '18:05 - 19:40',
      }
    },
    {
      'id': 8,
      'name': 'Факультет естественный наук, математики и технологий',
      'bellSchedule': {
        'big_break': '13:35 - 14:35',
        '1': '08:30 - 10:05',
        '2': '10:15 - 11:50',
        '3': '12:00 - 13:35',
        '4': '14:35 - 16:10',
        '5': '16:20 - 17:55',
        '6': '18:05 - 19:40',
      }
    },
    {
      'id': 9,
      'name': 'Социологический факультет',
      'bellSchedule': {
        'big_break': '13:35 - 14:35',
        '1': '08:30 - 10:05',
        '2': '10:15 - 11:50',
        '3': '12:00 - 13:35',
        '4': '14:35 - 16:10',
        '5': '16:20 - 17:55',
        '6': '18:05 - 19:40',
      }
    },
    {
      'id': 10,
      'name': 'Психолого-педагогический факультет',
      'bellSchedule': {
        'big_break': '13:35 - 14:35',
        '1': '08:30 - 10:05',
        '2': '10:15 - 11:50',
        '3': '12:00 - 13:35',
        '4': '14:35 - 16:10',
        '5': '16:20 - 17:55',
        '6': '18:05 - 19:40',
      }
    },
    {
      'id': 11,
      'name': 'Психолого-педагогический факультет',
      'bellSchedule': {
        'big_break': '13:35 - 14:35',
        '1': '08:30 - 10:05',
        '2': '10:15 - 11:50',
        '3': '12:00 - 13:35',
        '4': '14:35 - 16:10',
        '5': '16:20 - 17:55',
        '6': '18:05 - 19:40',
      }
    },
    {
      'id': 12,
      'name': 'Юридический факультет',
      'bellSchedule': {
        'big_break': '13:35 - 14:35',
        '1': '08:30 - 10:05',
        '2': '10:15 - 11:50',
        '3': '12:00 - 13:35',
        '4': '14:35 - 16:10',
        '5': '16:20 - 17:55',
        '6': '18:05 - 19:40',
      }
    },
  ];

  List<Map<String, dynamic>> _foundedFaculties = [];

  @override
  void initState() {
    _foundedFaculties = _allFaculties;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: Stack(children: <Widget>[
        SizedBox(
            child: Container(
          child: ListView.builder(
        padding: EdgeInsets.only(top: 100),
        itemCount: _foundedFaculties.length,
        itemBuilder: (context, index) {
          return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: _bellScheduleElevatedButton(
                _foundedFaculties[index]['id'],
                _foundedFaculties[index]['name'],
                _foundedFaculties[index]['icon'],
                _foundedFaculties[index]['bellSchedule'],
              ));
        },
          ),
        )),
        CustomPaint(
          painter: AppBarPainter(),
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: TextField(
                  cursorColor: Styles.primaryColor,
                  cursorRadius: const Radius.circular(2),
                  onChanged: (value) => _runFilter(value),
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Название факультета...',
                    focusColor: Styles.primaryColor,
                    suffixIcon: const Icon(Icons.search),
                    suffixIconColor: Styles.crossColor,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: Styles.crossColor)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: Styles.primaryColor)),
                  ),
                ),
              )),
        ),
      ]),
    );
  }

  Widget _bellScheduleElevatedButton(id, name, icon, bellSchedule) {
    return ElevatedButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (BuildContext context) {
                return Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10))),
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 4,
                            width: MediaQuery.of(context).size.width * 0.30,
                            decoration: BoxDecoration(
                                color: Styles.crossColor,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5))),
                          ),
                          const Gap(10),
                          Row(
                            children: [
                              const Icon(Icons.calendar_month_outlined),
                              const Gap(5),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Расписание звонков'),
                                    Text(
                                      name,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const Gap(10),
                          Row(
                            children: [
                              const Text('1 пара'),
                              Expanded(
                                  child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: DashedLineConnector(
                                  thickness: 1,
                                  gap: 2,
                                  dash: 3,
                                  direction: Axis.horizontal,
                                  color: Styles.crossColor,
                                ),
                              )),
                              Text(bellSchedule['1']),
                            ],
                          ),
                          const Gap(10),
                          Row(
                            children: [
                              const Text('2 пара'),
                              Expanded(
                                  child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: DashedLineConnector(
                                  thickness: 1,
                                  gap: 2,
                                  dash: 3,
                                  direction: Axis.horizontal,
                                  color: Styles.crossColor,
                                ),
                              )),
                              Text(bellSchedule['2']),
                            ],
                          ),
                          const Gap(10),
                          Row(
                            children: [
                              const Text('3 пара'),
                              Expanded(
                                  child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: DashedLineConnector(
                                  thickness: 1,
                                  gap: 2,
                                  dash: 3,
                                  direction: Axis.horizontal,
                                  color: Styles.crossColor,
                                ),
                              )),
                              Text(bellSchedule['3']),
                            ],
                          ),
                          const Gap(15),
                          Center(
                              child: Text(
                            'Большой перерыв ${bellSchedule['big_break']}',
                            style: TextStyle(
                                color: Styles.crossColor,
                                fontWeight: FontWeight.bold),
                          )),
                          const Gap(15),
                          Row(
                            children: [
                              const Text('4 пара'),
                              Expanded(
                                  child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: DashedLineConnector(
                                  thickness: 1,
                                  gap: 2,
                                  dash: 3,
                                  direction: Axis.horizontal,
                                  color: Styles.crossColor,
                                ),
                              )),
                              Text(bellSchedule['4']),
                            ],
                          ),
                          const Gap(10),
                          Row(
                            children: [
                              const Text('5 пара'),
                              Expanded(
                                  child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: DashedLineConnector(
                                  thickness: 1,
                                  gap: 2,
                                  dash: 3,
                                  direction: Axis.horizontal,
                                  color: Styles.crossColor,
                                ),
                              )),
                              Text(bellSchedule['5']),
                            ],
                          ),
                          const Gap(10),
                          Row(
                            children: [
                              const Text('6 пара'),
                              Expanded(
                                  child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: DashedLineConnector(
                                  thickness: 1,
                                  gap: 2,
                                  dash: 3,
                                  direction: Axis.horizontal,
                                  color: Styles.crossColor,
                                ),
                              )),
                              Text(bellSchedule['6']),
                            ],
                          ),
                        ],
                      ),
                    ));
              });
        },
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.only(left: 0, right: 20),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            minimumSize: Size(MediaQuery.of(context).size.width, 50),
            maximumSize: Size(MediaQuery.of(context).size.width, 50),
            backgroundColor: Colors.white,
            foregroundColor: Styles.textColor),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: Styles.primaryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  id.toString(),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(name),
              ),
            ),
          ],
        ));
  }

  void _runFilter(String value) {
    List<Map<String, dynamic>> result = [];
    if (value.isEmpty) {
      result = _allFaculties;
    } else {
      result = _allFaculties
          .where((faculty) =>
              faculty['name'].toLowerCase().contains(value.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundedFaculties = result;
    });
  }
}
