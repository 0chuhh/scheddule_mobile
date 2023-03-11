import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:schedule_mobile/models/schedule_model.dart';
import 'package:schedule_mobile/repositories/schedules_repository.dart';
import 'package:schedule_mobile/utils/day_names.dart';
import 'package:schedule_mobile/widgets/collapsible_calendar/collapsible_calendar.dart';
import 'package:schedule_mobile/widgets/app_bar_painter.dart';
import 'package:schedule_mobile/widgets/modal_choose_group.dart';
import 'package:schedule_mobile/widgets/schedule_list/schedule_list.dart';
import 'package:schedule_mobile/widgets/week.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/styles.dart';
import '../widgets/next_lesson.dart';
import 'dart:convert';

class MyScheduleScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyScheduleScreenState();
  }
}

class _MyScheduleScreenState extends State<MyScheduleScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<ScheduleModel> schedule = [];
  bool _loading = false;
  List<ScheduleModel> daySchedule = [];
  String _selectedGroup = '';

  void getSchedule(selectedGroup) async {
    setState(() {
      _loading = true;
    });
    if (!mounted) return;
    final selectedGroupTemp = await selectedGroup;

    if (this.mounted && selectedGroupTemp != null) {
      setState(() {
        _selectedGroup = selectedGroupTemp;
      });
      List<ScheduleModel>? mySchedule =
          await getScheduleFromSharedPreferences();

      if (mySchedule.isNotEmpty) {
        if (!mounted) return;
        setState(() {
          schedule = mySchedule;
          daySchedule = mySchedule
              .where((element) =>
                  element.weekDay.toLowerCase() ==
                      dayNames[DateTime.now().weekday - 1].toLowerCase() &&
                  element.weekType == Week(date: DateTime.now()).getWeekType())
              .toList();
          _loading = false;
        });
      } else {
        await SchedulesRepository()
            .getSchedulesByGroup(selectedGroupTemp)
            .then((value) {
          if (!mounted) return;
          saveSchedule(value, selectedGroupTemp);
          setState(() {
            schedule = value;
            daySchedule = value
                .where((element) =>
                    element.weekDay.toLowerCase() ==
                        dayNames[DateTime.now().weekday - 1].toLowerCase() &&
                    element.weekType ==
                        Week(date: DateTime.now()).getWeekType())
                .toList();
            _loading = false;
          });
        });
      }
    }
  }

  Future<String?> checkGroup() async {
    final selectedGroup = await _prefs.then((SharedPreferences prefs) {
      return prefs.getString('myGroup') ?? '';
    });
    if (selectedGroup == '') {
      Timer(const Duration(milliseconds: 100), () {
        showModalChooseGroupScreen();
      });
      return null;
    }
    return selectedGroup;
  }

  void saveSchedule(
      List<ScheduleModel> mySchedule, String selectedGroup) async {
    final SharedPreferences prefs = await _prefs;
    if (!mounted) return;
    await prefs.setString('savedScheduleGroup', selectedGroup);
    final String encoded = ScheduleModel.encode(mySchedule);
    await prefs.setString('mySchedule', encoded);
  }

  Future<List<ScheduleModel>> getScheduleFromSharedPreferences() async {
    String savedScheduleGroup = await _prefs.then((SharedPreferences prefs) {
      return prefs.getString('savedScheduleGroup') ?? '';
    });
    if (_selectedGroup != '' && _selectedGroup == savedScheduleGroup) {
      String encoded = await _prefs.then((SharedPreferences prefs) {
        return prefs.getString('mySchedule') ?? '';
      });
      if (encoded.isNotEmpty) {
        List<ScheduleModel> mySchedule = ScheduleModel.decode(encoded);
        return mySchedule;
      }
    }
    return [];
  }

  @override
  void initState() {
    getSchedule(checkGroup());
    print(daySchedule);
    super.initState();
  }

  void showModalChooseGroupScreen() {
    showDialog(
        routeSettings: RouteSettings(),
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => WillPopScope(
            child: ModalChooseGroup(
              onAccept: () async {
                final group = await checkGroup();
                if (group != null) {
                  getSchedule(group);
                }
              },
            ),
            onWillPop: () async => false));
  }

  void dayChanged(DateTime day) {
    setState(() {
      WeekType currentWeek = Week(date: day).getWeekType();
      daySchedule = schedule
          .where((element) =>
              element.weekDay.toLowerCase() ==
                  dayNames[day.weekday - 1].toLowerCase() &&
              element.weekType == currentWeek)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Styles.bgColor,
      extendBodyBehindAppBar: true,
      body: Stack(children: <Widget>[
        Positioned.fill(
            child: !_loading
                ? daySchedule.length > 0
                    ? ScheduleList(
                        schedule: daySchedule,
                      )
                    : Container(
                        margin: EdgeInsets.only(top: 150),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Сегодня у вас нет занятий. Советуем потратить это время на самоподготовку.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xFF9498BE),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16),
                              ),
                              SvgPicture.asset(
                                'assets/noLessons.svg',
                                width: 270,
                              )
                            ]),
                      )
                : const Center(child: CircularProgressIndicator())),
        Stack(children: <Widget>[
          CustomPaint(
            painter: AppBarPainter(),
            child: Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              height: 260,
              child: NextLesson(),
            ),
          ),
          CollapsibleCalendar(
            onDayChanged: (selectedDay) {
              dayChanged(selectedDay);
            },
          ),
        ])
      ]),
    );
  }
}
