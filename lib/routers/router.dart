import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:schedule_mobile/screens/root_screen.dart';
import 'package:schedule_mobile/screens/bell_schedule_screen.dart';
import 'package:schedule_mobile/screens/my_schedule_screen.dart';
import 'package:schedule_mobile/screens/schedules_screen.dart';
import 'package:schedule_mobile/screens/settings_screen.dart';

@MaterialAutoRouter(replaceInRouteName: 'Screen,Route', routes: <AutoRoute>[
  AutoRoute(path: '/', page: RootScreen, children: [
    AutoRoute(
      path: 'my-schedule',
      name: 'MyScheduleRouter',
      page: MyScheduleScreen,
    ),
    AutoRoute(
        path: 'schedules',
        name: 'SchedulesRouter',
        page: EmptyRouterPage,
        children: [
          AutoRoute(path: '', page: SchedulesScreen),
          AutoRoute(path: 'my-schedule', page: MyScheduleScreen),
          AutoRoute(
              path: 'classroom-schedule',
              page: MyScheduleScreen,
              name: 'ClassRoomScheduleRouter'),
        ]),
    AutoRoute(
      path: 'bell-schedule',
      name: 'BellScheduleRouter',
      page: BellScheduleScreen,
    ),
    AutoRoute(
      path: 'settings',
      name: 'SettingsRouter',
      page: SettingsScreen,
    ),
  ]),
])
class $AppRouter {}
