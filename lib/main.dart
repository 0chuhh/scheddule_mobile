import 'package:flutter/material.dart';
import 'package:schedule_mobile/utils/styles.dart';
import 'package:schedule_mobile/widgets/collapsible-calendar/collapsible-calendar.dart';
import 'package:schedule_mobile/screens/main_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Schedule ZabGU',
      home: const MainScreen(),  
      theme: ThemeData(fontFamily: 'Montserrat',),
    );
  }
}
