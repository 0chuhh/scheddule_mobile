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

import '../screens/root_screen.dart' as _i1;
import '../screens/bell_schedule_screen.dart' as _i2;
import '../screens/my_schedule_screen.dart' as _i3;
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
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.MyScheduleScreen(),
      );
    },
    SchedulesRouter.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
      );
    },
    SettingsRouter.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.SettingsScreen(),
      );
    },
    SchedulesRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.SchedulesScreen(),
      );
    },
    MyScheduleRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.MyScheduleScreen(),
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
                  path: 'schedule',
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
class MyScheduleRouter extends _i7.PageRouteInfo<void> {
  const MyScheduleRouter()
      : super(
          MyScheduleRouter.name,
          path: 'my-schedule',
        );

  static const String name = 'MyScheduleRouter';
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
class SettingsRouter extends _i7.PageRouteInfo<void> {
  const SettingsRouter()
      : super(
          SettingsRouter.name,
          path: 'settings',
        );

  static const String name = 'SettingsRouter';
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
class MyScheduleRoute extends _i7.PageRouteInfo<void> {
  const MyScheduleRoute()
      : super(
          MyScheduleRoute.name,
          path: 'schedule',
        );

  static const String name = 'MyScheduleRoute';
}
