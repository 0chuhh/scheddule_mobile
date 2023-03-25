import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schedule_mobile/schedule_app.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting().then((_) => {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]),
        runApp(ScheduleApp())
      });
}
