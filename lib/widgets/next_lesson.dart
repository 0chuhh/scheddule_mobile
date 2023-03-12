import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../themes/styles.dart';

class NextLesson extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NextLessonState();
  }
}

class _NextLessonState extends State<NextLesson> {
  bool notif = false;
  @override
  void initState() {
    // TODO: implement initState
    notif = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Colors.transparent,
        margin: EdgeInsets.only(top: 140),
        padding: const EdgeInsets.only(left: 20, right: 20),
        alignment: Alignment.bottomCenter,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Ближайшаяя пара',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                Container(
                  width: 60,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: Styles.accentColor,
                      borderRadius: BorderRadius.circular(50)),
                  child: const Text(
                    'Лекция',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                )
              ],
            ),
            const Gap(10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xffdbdaff), Color(0x29dbdaff)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(6)),
                          child: const Text(
                            '08',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 25),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Gap(5),
                        Column(
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                  color: const Color(0xff1e1e1e),
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                            const Gap(3),
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                  color: const Color(0xff1e1e1e),
                                  borderRadius: BorderRadius.circular(50)),
                            )
                          ],
                        ),
                        const Gap(5),
                        Container(
                          alignment: Alignment.center,
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xffdbdaff), Color(0x29dbdaff)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(6)),
                          child: const Text(
                            '30',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 25),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                    const Gap(10),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          notif = !notif;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 95,
                        height: 25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: !notif?Styles.primaryColor: Color.fromARGB(158, 209, 209, 209)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Transform.rotate(
                              angle: 6.5,
                              child:  Icon(
                                Icons.notifications_outlined,
                                size: 15,
                                color: !notif? Colors.white: Color.fromARGB(255, 104, 103, 103),
                              ),
                            ),
                             Text(
                              'Напомнить',
                              style:
                                  TextStyle(fontSize: 10, color: !notif? Colors.white: Color.fromARGB(255, 68, 68, 68)),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const Gap(7),
                Container(
                  alignment: Alignment.topLeft,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Информационные технологии в цифровой экономике',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            height: 1),
                      ),
                      const Text(
                        'Яковлева Лидия Леонидовна',
                        style: TextStyle(fontSize: 10),
                      ),
                      const Gap(10),
                      Container(
                        alignment: Alignment.bottomCenter,
                        height: 20,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Каф.ПиМ',
                              style: TextStyle(fontSize: 10),
                            ),
                            Text(
                              'Ауд. 03-400',
                              style: TextStyle(fontSize: 10),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
