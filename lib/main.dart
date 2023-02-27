import 'package:flutter/material.dart';
import 'package:schedule_mobile/widgets/collapsible-calendar/callapsible-calendar.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: CollapsibleCalendar(),
        ),
      ),
    );
  }
}
