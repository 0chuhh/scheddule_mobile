import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:schedule_mobile/routers/router.gr.dart';
import 'package:schedule_mobile/screens/my_schedule_screen.dart';
import 'package:schedule_mobile/themes/styles.dart';
import 'package:schedule_mobile/widgets/bottom_nav_bar.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

GlobalKey<MyScheduleScreenState> myScheduleKey = GlobalKey();

class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key);
  void onGroupChange() {
    myScheduleKey.currentState?.getSchedule();
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: [
        BellScheduleRouter(),
        MyScheduleRouter(
            onGroupChanged: (string) {
              print(string);
            },
            key: myScheduleKey),
        SchedulesRouter(),
        SettingsRouter(onGroupChanged: onGroupChange),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: [
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  const Icon(Icons.watch_later_outlined),
                  Container(
                    width: 100,
                    child: Text(
                      "Расписание звонков",
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 1,
                          fontSize: 10,
                          color: tabsRouter.activeIndex == 0
                              ? Styles.primaryColor
                              : Styles.textColor),
                    ),
                  )
                ],
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  const Icon(Icons.calendar_month_outlined),
                  Container(
                    width: 100,
                    child: Text(
                      "Мое расписание",
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 1,
                          fontSize: 10,
                          color: tabsRouter.activeIndex == 1
                              ? Styles.primaryColor
                              : Styles.textColor),
                    ),
                  )
                ],
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Container(
                transform: Matrix4.compose(vector.Vector3(0, 0, 0),
                    vector.Quaternion(0, 0, 0, 0), vector.Vector3(1, 1, 1)),
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    const Icon(Icons.calendar_today_outlined),
                    Container(
                      width: 100,
                      child: Text(
                        "Расписание",
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            height: 1,
                            fontSize: 10,
                            color: tabsRouter.activeIndex == 2
                                ? Styles.primaryColor
                                : Styles.textColor),
                      ),
                    )
                  ],
                ),
              ),
              label: "",
            ),
            BottomNavigationBarItem(
                icon: Column(
                  children: [
                    const Icon(Icons.settings),
                    Container(
                      width: 100,
                      child: Text(
                        "Настройки",
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            height: 1,
                            fontSize: 10,
                            color: tabsRouter.activeIndex == 3
                                ? Styles.primaryColor
                                : Styles.textColor),
                      ),
                    )
                  ],
                ),
                label: ""),
          ],
        );
      },
    );
  }
}
