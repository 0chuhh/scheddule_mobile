import 'package:flutter/material.dart';
import 'package:flutter_theme_provider/flutter_theme_provider.dart';
import 'package:schedule_mobile/widgets/dark_bar_painter.dart';

import '../themes/styles.dart';
import '../widgets/app_bar_painter.dart';
import '../widgets/schedule_search_cards.dart';
import 'package:provider/provider.dart';

class SchedulesScreen extends StatelessWidget {
  const SchedulesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
        builder: (context, theme, child) => Scaffold(
              resizeToAvoidBottomInset: false,
              body: Stack(children: <Widget>[
                const Positioned.fill(
                  child: ScheduleSearchCards(),
                ),
                Stack(
                  children: [
                    CustomPaint(
                      painter: theme.getThemeName() == 'Light'
                          ? AppBarPainter()
                          : DarkAppBarPainter(),
                      child: Container(
                        margin: const EdgeInsets.only(top: 40),
                        width: MediaQuery.of(context).size.width,
                        height: 70,
                        child: const Text(
                          'Расписание по фильтрам',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xFF979CB7),
                              fontSize: 20,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                    Container()
                  ],
                ),
              ]),
            ));
  }
}
