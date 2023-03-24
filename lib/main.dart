import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schedule_mobile/schedule_app.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting().then((_) => {
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
        )),
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]),
        runApp(ScheduleApp())
      });
}
