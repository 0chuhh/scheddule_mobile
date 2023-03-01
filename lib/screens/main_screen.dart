import 'package:flutter/material.dart';
import 'package:schedule_mobile/screens/bell_schedule_screen.dart';
import 'package:schedule_mobile/screens/my_schedule_screen.dart';
import 'package:schedule_mobile/screens/reminders_screen.dart';
import 'package:schedule_mobile/screens/schedules_screen.dart';
import 'package:schedule_mobile/screens/settings_screen.dart';
import 'package:schedule_mobile/utils/styles.dart';
import 'package:schedule_mobile/widgets/custom_app_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static final List<Widget> _screens = <Widget>[
    const RemindersScreen(),
    const BellScheduleScreen(),
    const MyScheduleScreen(),
    const SchedulesScreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const CustomAppBar(
          title: Text('AppBar'),
        ),
        backgroundColor: Styles.bgColor,
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
          unselectedItemColor: Styles.textColor,
          selectedItemColor: Styles.primaryColor,
          unselectedFontSize: 12,
          selectedFontSize: 12,
          backgroundColor: Colors.white,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: "notifications",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timer),
              label: "alarm schedule",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.schedule),
              label: "my schedule",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.schedule),
              label: "schedule",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "settings",
            ),
          ],
        ),
      ),
    );
  }
}
