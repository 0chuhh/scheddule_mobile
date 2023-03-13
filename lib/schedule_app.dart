import 'package:flutter/material.dart';
import 'package:schedule_mobile/routers/router.gr.dart';
import 'package:schedule_mobile/themes/theme.dart';

class ScheduleApp extends StatelessWidget {
  ScheduleApp({Key? key}) : super(key: key);
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Schedule ZabGU',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
