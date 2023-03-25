import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schedule_mobile/routers/router.gr.dart';
import 'package:schedule_mobile/themes/theme.dart';
import 'package:flutter_theme_provider/flutter_theme_provider.dart';
import 'package:provider/provider.dart';

class ScheduleApp extends StatefulWidget {
  ScheduleApp({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ScheduleAppState();
  }
}

class _ScheduleAppState extends State<ScheduleApp> {
  final _appRouter = AppRouter();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) =>
                ThemeProvider(defaultThemeName: "Light", themes: [
                  {"Light": lightTheme},
                  {"Dark": darkTheme}
                ])),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, theme, child) {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent,
            systemNavigationBarColor:
                theme.getTheme()?.navigationBarTheme.backgroundColor,
            systemNavigationBarIconBrightness: Brightness.dark,
          ));
          return MaterialApp.router(
            title: 'Расписание ЗабГУ',
            debugShowCheckedModeBanner: false,
            theme: theme.getTheme(),
            routerDelegate: _appRouter.delegate(),
            routeInformationParser: _appRouter.defaultRouteParser(),
          );
        },
      ),
    );
    // return MaterialApp.router(
    //   title: 'Расписание ЗабГУ',
    //   debugShowCheckedModeBanner: false,
    //   theme: lightTheme,
    //   darkTheme: darkTheme,
    //   themeMode: _themeManager.themeMode,
    //   routerDelegate: _appRouter.delegate(),
    //   routeInformationParser: _appRouter.defaultRouteParser(),
    // );
  }
}
