import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../utils/styles.dart';

class NextLesson extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NextLessonState();
  }
}

class _NextLessonState extends State<NextLesson> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.17),
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
            Gap(10),
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
                              gradient: LinearGradient(
                                colors: [Color(0xffdbdaff), Color(0x29dbdaff)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(6)),
                          child: Text(
                            '08',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 25),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Gap(5),
                        Column(
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                  color: Color(0xff1e1e1e),
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                            Gap(3),
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                  color: Color(0xff1e1e1e),
                                  borderRadius: BorderRadius.circular(50)),
                            )
                          ],
                        ),
                        Gap(5),
                        Container(
                          alignment: Alignment.center,
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xffdbdaff), Color(0x29dbdaff)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(6)),
                          child: Text(
                            '30',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 25),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                    Gap(10),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        width: 95,
                        height: 25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Styles.primaryColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Transform.rotate(
                              angle: 6.5,
                              child: Icon(
                                Icons.notifications_outlined,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Напомнить',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Gap(7),
                Container(
                  alignment: Alignment.topLeft,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Информационные технологии в цифровой экономике',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            height: 1),
                      ),
                      Text(
                        'Яковлева Лидия Леонидовна',
                        style: TextStyle(fontSize: 10),
                      ),
                      Gap(10),
                      Container(
                        alignment: Alignment.bottomCenter,
                        height: 20,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
