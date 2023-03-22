// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:auto_route/empty_router_widgets.dart' as _i4;
import 'package:flutter/material.dart' as _i8;

import '../screens/bell_schedule_screen.dart' as _i2;
import '../screens/my_schedule_screen.dart' as _i3;
import '../screens/root_screen.dart' as _i1;
import '../screens/schedules_screen.dart' as _i6;
import '../screens/settings_screen.dart' as _i5;

class AppRouter extends _i7.RootStackRouter {
  AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    RootRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.RootScreen(),
      );
    },
    BellScheduleRouter.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.BellScheduleScreen(),
      );
    },
    MyScheduleRouter.name: (routeData) {
      final args = routeData.argsAs<MyScheduleRouterArgs>(
          orElse: () => const MyScheduleRouterArgs());
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.MyScheduleScreen(
          key: args.key,
          showCalendar: args.showCalendar,
          queryParam: args.queryParam,
          scheduleFormat: args.scheduleFormat,
          screenType: args.screenType,
        ),
      );
    },
    SchedulesRouter.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
      );
    },
    SettingsRouter.name: (routeData) {
      final args = routeData.argsAs<SettingsRouterArgs>();
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.SettingsScreen(
          key: args.key,
          onGroupChanged: args.onGroupChanged,
        ),
      );
    },
    SchedulesRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.SchedulesScreen(),
      );
    },
    MyScheduleRoute.name: (routeData) {
      final args = routeData.argsAs<MyScheduleRouteArgs>(
          orElse: () => const MyScheduleRouteArgs());
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.MyScheduleScreen(
          key: args.key,
          showCalendar: args.showCalendar,
          queryParam: args.queryParam,
          scheduleFormat: args.scheduleFormat,
          screenType: args.screenType,
        ),
      );
    },
    ClassRoomScheduleRouter.name: (routeData) {
      final args = routeData.argsAs<ClassRoomScheduleRouterArgs>(
          orElse: () => const ClassRoomScheduleRouterArgs());
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.MyScheduleScreen(
          key: args.key,
          showCalendar: args.showCalendar,
          queryParam: args.queryParam,
          scheduleFormat: args.scheduleFormat,
          screenType: args.screenType,
        ),
      );
    },
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(
          RootRoute.name,
          path: '/',
          children: [
            _i7.RouteConfig(
              BellScheduleRouter.name,
              path: 'bell-schedule',
              parent: RootRoute.name,
            ),
            _i7.RouteConfig(
              MyScheduleRouter.name,
              path: 'my-schedule',
              parent: RootRoute.name,
            ),
            _i7.RouteConfig(
              SchedulesRouter.name,
              path: 'schedules',
              parent: RootRoute.name,
              children: [
                _i7.RouteConfig(
                  SchedulesRoute.name,
                  path: '',
                  parent: SchedulesRouter.name,
                ),
                _i7.RouteConfig(
                  MyScheduleRoute.name,
                  path: 'my-schedule',
                  parent: SchedulesRouter.name,
                ),
                _i7.RouteConfig(
                  ClassRoomScheduleRouter.name,
                  path: 'classroom-schedule',
                  parent: SchedulesRouter.name,
                ),
              ],
            ),
            _i7.RouteConfig(
              SettingsRouter.name,
              path: 'settings',
              parent: RootRoute.name,
            ),
          ],
        )
      ];
}

/// generated route for
/// [_i1.RootScreen]
class RootRoute extends _i7.PageRouteInfo<void> {
  const RootRoute({List<_i7.PageRouteInfo>? children})
      : super(
          RootRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'RootRoute';
}

/// generated route for
/// [_i2.BellScheduleScreen]
class BellScheduleRouter extends _i7.PageRouteInfo<void> {
  const BellScheduleRouter()
      : super(
          BellScheduleRouter.name,
          path: 'bell-schedule',
        );

  static const String name = 'BellScheduleRouter';
}

/// generated route for
/// [_i3.MyScheduleScreen]
class MyScheduleRouter extends _i7.PageRouteInfo<MyScheduleRouterArgs> {
  MyScheduleRouter({
    _i8.Key? key,
    bool showCalendar = true,
    String? queryParam,
    String scheduleFormat = 'Очная',
    _i3.ScheduleScreenType screenType = _i3.ScheduleScreenType.mySchedule,
  }) : super(
          MyScheduleRouter.name,
          path: 'my-schedule',
          args: MyScheduleRouterArgs(
            key: key,
            showCalendar: showCalendar,
            queryParam: queryParam,
            scheduleFormat: scheduleFormat,
            screenType: screenType,
          ),
        );

  static const String name = 'MyScheduleRouter';
}

class MyScheduleRouterArgs {
  const MyScheduleRouterArgs({
    this.key,
    this.showCalendar = true,
    this.queryParam,
    this.scheduleFormat = 'Очная',
    this.screenType = _i3.ScheduleScreenType.mySchedule,
  });

  final _i8.Key? key;

  final bool showCalendar;

  final String? queryParam;

  final String scheduleFormat;

  final _i3.ScheduleScreenType screenType;

  @override
  String toString() {
    return 'MyScheduleRouterArgs{key: $key, showCalendar: $showCalendar, queryParam: $queryParam, scheduleFormat: $scheduleFormat, screenType: $screenType}';
  }
}

/// generated route for
/// [_i4.EmptyRouterPage]
class SchedulesRouter extends _i7.PageRouteInfo<void> {
  const SchedulesRouter({List<_i7.PageRouteInfo>? children})
      : super(
          SchedulesRouter.name,
          path: 'schedules',
          initialChildren: children,
        );

  static const String name = 'SchedulesRouter';
}

/// generated route for
/// [_i5.SettingsScreen]
class SettingsRouter extends _i7.PageRouteInfo<SettingsRouterArgs> {
  SettingsRouter({
    _i8.Key? key,
    required void Function() onGroupChanged,
  }) : super(
          SettingsRouter.name,
          path: 'settings',
          args: SettingsRouterArgs(
            key: key,
            onGroupChanged: onGroupChanged,
          ),
        );

  static const String name = 'SettingsRouter';
}

class SettingsRouterArgs {
  const SettingsRouterArgs({
    this.key,
    required this.onGroupChanged,
  });

  final _i8.Key? key;

  final void Function() onGroupChanged;

  @override
  String toString() {
    return 'SettingsRouterArgs{key: $key, onGroupChanged: $onGroupChanged}';
  }
}

/// generated route for
/// [_i6.SchedulesScreen]
class SchedulesRoute extends _i7.PageRouteInfo<void> {
  const SchedulesRoute()
      : super(
          SchedulesRoute.name,
          path: '',
        );

  static const String name = 'SchedulesRoute';
}

/// generated route for
/// [_i3.MyScheduleScreen]
class MyScheduleRoute extends _i7.PageRouteInfo<MyScheduleRouteArgs> {
  MyScheduleRoute({
    _i8.Key? key,
    bool showCalendar = true,
    String? queryParam,
    String scheduleFormat = 'Очная',
    _i3.ScheduleScreenType screenType = _i3.ScheduleScreenType.mySchedule,
  }) : super(
          MyScheduleRoute.name,
          path: 'my-schedule',
          args: MyScheduleRouteArgs(
            key: key,
            showCalendar: showCalendar,
            queryParam: queryParam,
            scheduleFormat: scheduleFormat,
            screenType: screenType,
          ),
        );

  static const String name = 'MyScheduleRoute';
}

class MyScheduleRouteArgs {
  const MyScheduleRouteArgs({
    this.key,
    this.showCalendar = true,
    this.queryParam,
    this.scheduleFormat = 'Очная',
    this.screenType = _i3.ScheduleScreenType.mySchedule,
  });

  final _i8.Key? key;

  final bool showCalendar;

  final String? queryParam;

  final String scheduleFormat;

  final _i3.ScheduleScreenType screenType;

  @override
  String toString() {
    return 'MyScheduleRouteArgs{key: $key, showCalendar: $showCalendar, queryParam: $queryParam, scheduleFormat: $scheduleFormat, screenType: $screenType}';
  }
}

/// generated route for
/// [_i3.MyScheduleScreen]
class ClassRoomScheduleRouter
    extends _i7.PageRouteInfo<ClassRoomScheduleRouterArgs> {
  ClassRoomScheduleRouter({
    _i8.Key? key,
    bool showCalendar = true,
    String? queryParam,
    String scheduleFormat = 'Очная',
    _i3.ScheduleScreenType screenType = _i3.ScheduleScreenType.mySchedule,
  }) : super(
          ClassRoomScheduleRouter.name,
          path: 'classroom-schedule',
          args: ClassRoomScheduleRouterArgs(
            key: key,
            showCalendar: showCalendar,
            queryParam: queryParam,
            scheduleFormat: scheduleFormat,
            screenType: screenType,
          ),
        );

  static const String name = 'ClassRoomScheduleRouter';
}

class ClassRoomScheduleRouterArgs {
  const ClassRoomScheduleRouterArgs({
    this.key,
    this.showCalendar = true,
    this.queryParam,
    this.scheduleFormat = 'Очная',
    this.screenType = _i3.ScheduleScreenType.mySchedule,
  });

  final _i8.Key? key;

  final bool showCalendar;

  final String? queryParam;

  final String scheduleFormat;

  final _i3.ScheduleScreenType screenType;

  @override
  String toString() {
    return 'ClassRoomScheduleRouterArgs{key: $key, showCalendar: $showCalendar, queryParam: $queryParam, scheduleFormat: $scheduleFormat, screenType: $screenType}';
  }
}
