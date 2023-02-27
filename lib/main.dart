import 'package:flutter/material.dart';
import 'package:schedule_mobile/screens/main_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Schedule ZabGU',
      home: MainScreen(),
    );
  }
}
