import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_theme_provider/flutter_theme_provider.dart';
import 'package:schedule_mobile/routers/router.gr.dart';
import 'package:schedule_mobile/screens/my_schedule_screen.dart';
import 'package:schedule_mobile/themes/styles.dart';
import 'package:schedule_mobile/widgets/bottom_nav_bar.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:provider/provider.dart';

GlobalKey<MyScheduleScreenState> myScheduleKey = GlobalKey();

class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key);
  void onGroupChange() {
    myScheduleKey.currentState?.getSchedule();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return Consumer<ThemeProvider>(
        builder: (context, theme, child) => MediaQuery(
            data: mediaQueryData.copyWith(textScaleFactor: 1.0),
            child: AutoTabsScaffold(
              routes: [
                MyScheduleRouter(key: myScheduleKey),
                const SchedulesRouter(),
                const BellScheduleRouter(),
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
                                  color: tabsRouter.activeIndex == 0
                                      ? theme.getThemeName() == 'Light'
                                          ? Styles.primaryColor
                                          : Colors.white
                                      : theme.getThemeName() == 'Light'
                                          ? Styles.textColor
                                          : const Color(0xFF94A3B8)),
                            ),
                          )
                        ],
                      ),
                      label: "",
                    ),
                    BottomNavigationBarItem(
                      icon: Container(
                        transform: Matrix4.compose(
                            vector.Vector3(0, 0, 0),
                            vector.Quaternion(0, 0, 0, 0),
                            vector.Vector3(1, 1, 1)),
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
                                    color: tabsRouter.activeIndex == 1
                                        ? theme.getThemeName() == 'Light'
                                            ? Styles.primaryColor
                                            : Colors.white
                                        : theme.getThemeName() == 'Light'
                                            ? Styles.textColor
                                            : const Color(0xFF94A3B8)),
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
                                  color: tabsRouter.activeIndex == 2
                                      ? theme.getThemeName() == 'Light'
                                          ? Styles.primaryColor
                                          : Colors.white
                                      : theme.getThemeName() == 'Light'
                                          ? Styles.textColor
                                          : const Color(0xFF94A3B8)),
                            ),
                          )
                        ],
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
                                        ? theme.getThemeName() == 'Light'
                                            ? Styles.primaryColor
                                            : Colors.white
                                        : theme.getThemeName() == 'Light'
                                            ? Styles.textColor
                                            : const Color(0xFF94A3B8)),
                              ),
                            )
                          ],
                        ),
                        label: ""),
                  ],
                );
              },
            )));
  }
}
