import 'package:flutter/material.dart';
import 'package:schedule_mobile/screens/bell_schedule_screen.dart';
import 'package:schedule_mobile/screens/my_schedule_screen.dart';
import 'package:schedule_mobile/screens/schedules_screen.dart';
import 'package:schedule_mobile/utils/styles.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 1;
  static final List<Widget> _screens = <Widget>[
    // const RemindersScreen(),
    const BellScheduleScreen(),
    const MyScheduleScreen(),
    const SchedulesScreen(),
    // const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: _screens[_selectedIndex],
        ),
        bottomNavigationBar: bottomNavigationBar);
  }

  Widget get bottomNavigationBar {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 5),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        child: BottomNavigationBar(
          unselectedIconTheme: IconThemeData(size: 20),
          selectedIconTheme: IconThemeData(size: 25),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedLabelStyle: TextStyle(),
          unselectedItemColor: Styles.textColor,
          selectedItemColor: Styles.primaryColor,
          unselectedFontSize: 12,
          selectedFontSize: 12,
          backgroundColor: Colors.white,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          items: [
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.notifications),
            //   label: "notifications",
            // ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Icon(Icons.watch_later_outlined),
                  Container(
                    width: 100,
                    child: Text(
                      "Расписание звонков",
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 1,
                          fontSize: 10,
                          color: _selectedIndex == 0
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
                  Icon(Icons.calendar_month_outlined),
                  Container(
                    width: 100,
                    child: Text(
                      "Мое расписание",
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 1,
                          fontSize: 10,
                          color: _selectedIndex == 1
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
                    Icon(Icons.calendar_today_outlined),
                    Container(
                      width: 100,
                      child: Text(
                        "Расписание",
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            height: 1,
                            fontSize: 10,
                            color: _selectedIndex == 2
                                ? Styles.primaryColor
                                : Styles.textColor),
                      ),
                    )
                  ],
                ),
              ),
              label: "",
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.settings),
            //   label: "settings",
            // ),
          ],
        ),
      ),
    );
  }
}
