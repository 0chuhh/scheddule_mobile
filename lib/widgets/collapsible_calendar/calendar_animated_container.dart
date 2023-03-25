import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_theme_provider/flutter_theme_provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';

class CalendarAnimatedContainer extends StatelessWidget {
  const CalendarAnimatedContainer(
      {required this.format,
      required this.children,
      super.key,
      this.marginTop = 40});
  final double marginTop;
  final CalendarFormat format;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
        builder: (context, theme, child) => AnimatedContainer(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            curve: Curves.easeOutBack,
            duration: Duration(
                milliseconds: format == CalendarFormat.month ? 500 : 400),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(1, 5),
                    spreadRadius: 3,
                    blurRadius: 9,
                    color: theme.getThemeName() == 'Light'
                        ? const Color.fromRGBO(200, 202, 224, 1)
                        : const Color.fromARGB(255, 34, 34, 34),
                  )
                ],
                color: theme.getThemeName() == 'Light'
                    ? Colors.white
                    : const Color(0xFF3D3D3D),
                borderRadius: const BorderRadius.all(Radius.circular(50))),
            height: format == CalendarFormat.week ? 80 : 350,
            margin: EdgeInsets.only(top: marginTop),
            child: SingleChildScrollView(
                child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.bottomCenter,
                    children: children))));
  }
}
