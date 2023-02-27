import 'package:flutter/material.dart';
import 'package:schedule_mobile/screens/bell_schedule_screen.dart';
import 'package:schedule_mobile/screens/my_schedule_screen.dart';
import 'package:schedule_mobile/screens/notifications_screen.dart';
import 'package:schedule_mobile/screens/schedules_screen.dart';
import 'package:schedule_mobile/screens/settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static final List<Widget> _screens = <Widget>[
    const NotificationScreen(),
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
      body: Center(
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
    );
  }
}
