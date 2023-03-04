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
      'icon': Icons.build,
    },
    {
      'id': 2,
      'name': 'Факультет строительства и экологии',
      'icon': Icons.build,
    },
    {
      'id': 3,
      'name': 'Факультет строительства и экологии',
      'icon': Icons.build,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: Column(
        children: [
          Stack(children: <Widget>[
            CustomPaint(
              painter: AppBarPainter(),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 130,
                child: SafeArea(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        boxShadow: [
                          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 5),
                        ]),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text("Название факультета"),
                          Spacer(),
                          Icon(Icons.search),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                ElevatedButton(
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
                                height: 280,
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
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
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: const [
                                              Text('Расписание звонков'),
                                              Text('Энергетический факультет'),
                                            ],
                                          )
                                        ],
                                      ),
                                      const Gap(10),
                                      Row(
                                        children: [
                                          const Text('1 пара'),
                                          Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: DashedLineConnector(
                                                  thickness: 1,
                                                  gap: 2,
                                                  dash: 3,
                                                  direction: Axis.horizontal,
                                                  color: Styles.crossColor,
                                                ),
                                              )
                                          ),
                                          const Text('08:30 - 10:05'),
                                        ],
                                      ),
                                      const Gap(10),
                                      Row(
                                        children: [
                                          const Text('2 пара'),
                                          Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: DashedLineConnector(
                                                  thickness: 1,
                                                  gap: 2,
                                                  dash: 3,
                                                  direction: Axis.horizontal,
                                                  color: Styles.crossColor,
                                                ),
                                              )
                                          ),
                                          const Text('10:15 - 11:50'),
                                        ],
                                      ),
                                      const Gap(10),
                                      Row(
                                        children: [
                                          const Text('3 пара'),
                                          Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: DashedLineConnector(
                                                  thickness: 1,
                                                  gap: 2,
                                                  dash: 3,
                                                  direction: Axis.horizontal,
                                                  color: Styles.crossColor,
                                                ),
                                              )
                                          ),
                                          const Text('12:00 - 13:35'),
                                        ],
                                      ),
                                      const Gap(15),
                                      Center(
                                          child: Text(
                                        'Большой перерыв 13:35 - 14:35',
                                        style: TextStyle(
                                            color: Styles.crossColor, fontWeight: FontWeight.bold),
                                      )),
                                      const Gap(15),
                                      Row(
                                        children: [
                                          const Text('4 пара'),
                                          Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: DashedLineConnector(
                                                  thickness: 1,
                                                  gap: 2,
                                                  dash: 3,
                                                  direction: Axis.horizontal,
                                                  color: Styles.crossColor,
                                                ),
                                              )
                                          ),
                                          const Text('14:35 - 16:10'),
                                        ],
                                      ),
                                      const Gap(10),
                                      Row(
                                        children: [
                                          const Text('5 пара'),
                                          Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: DashedLineConnector(
                                                  thickness: 1,
                                                  gap: 2,
                                                  dash: 3,
                                                  direction: Axis.horizontal,
                                                  color: Styles.crossColor,
                                                ),
                                              )
                                          ),
                                          const Text('16:20 - 17:55'),
                                        ],
                                      ),
                                      const Gap(10),
                                      Row(
                                        children: [
                                          const Text('6 пара'),
                                          Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: DashedLineConnector(
                                                  thickness: 1,
                                                  gap: 2,
                                                  dash: 3,
                                                  direction: Axis.horizontal,
                                                  color: Styles.crossColor,
                                                ),
                                              )
                                          ),
                                          const Text('18:05 - 19:40'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ));
                          });
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.only(left: 0, right: 20),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        minimumSize: Size(MediaQuery.of(context).size.width, 40),
                        maximumSize: Size(MediaQuery.of(context).size.width, 40),
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
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              '01',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text('Энергетический факультет'),
                        ),
                        const Spacer(),
                        const Icon(Icons.factory),
                      ],
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
