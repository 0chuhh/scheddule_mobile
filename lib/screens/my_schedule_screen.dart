import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:schedule_mobile/models/schedule_model.dart';
import 'package:schedule_mobile/repositories/schedules_repository.dart';
import 'package:schedule_mobile/utils/day_names.dart';
import 'package:schedule_mobile/widgets/collapsible_calendar/collapsible_calendar.dart';
import 'package:schedule_mobile/widgets/app_bar_painter.dart';
import 'package:schedule_mobile/widgets/modal_choose_group.dart';
import 'package:schedule_mobile/widgets/schedule_list/schedule_list.dart';
import 'package:schedule_mobile/widgets/week.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../themes/styles.dart';
import '../widgets/next_lesson.dart';

enum ScheduleScreenType {
  mySchedule,
  classroomSchedule,
  lecturerSchedule,
  groupSchedule
}

class MyScheduleScreen extends StatefulWidget {
  MyScheduleScreen(
      {super.key,
      this.showCalendar = true,
      this.queryParam,
      this.screenType = ScheduleScreenType.mySchedule});
  final bool showCalendar;

  final ScheduleScreenType screenType;
  final String? queryParam;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyScheduleScreenState();
  }
}

class MyScheduleScreenState extends State<MyScheduleScreen> {
  GlobalKey<CollapsibleCalendarState> _collapsibleCalendarKey = GlobalKey();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<ScheduleModel> schedule = [];
  bool _loading = false;
  List<ScheduleModel> daySchedule = [];
  String _selectedGroup = '';

  void getSchedule() async {
    if (!mounted) return;
    setState(() {
      _loading = true;
    });
    if (widget.screenType == ScheduleScreenType.mySchedule) {
      final selectedGroupTemp = await checkGroup();

      if (this.mounted && selectedGroupTemp != null) {
        _collapsibleCalendarKey.currentState?.changeDay(DateTime.now());
        setState(() {
          _selectedGroup = selectedGroupTemp;
        });
        List<ScheduleModel>? newSchedule =
            await getScheduleFromSharedPreferences(_selectedGroup);

        if (newSchedule.isNotEmpty) {
          if (!mounted) return;
          setSchedule(newSchedule);
        } else {
          await SchedulesRepository()
              .getSchedulesByGroup(selectedGroupTemp)
              .then((newSchedule) {
            if (!mounted) return;
            saveSchedule(newSchedule, selectedGroupTemp);
            setSchedule(newSchedule);
          });
        }
      }
    } else {
      getClassRoomSchedule(widget.queryParam);
    }
  }

  void setSchedule(List<ScheduleModel> newSchedule) {
    setState(() {
      schedule = newSchedule;
      daySchedule = newSchedule
          .where((element) =>
              element.weekDay.toLowerCase() ==
                  dayNames[DateTime.now().weekday - 1].toLowerCase() &&
              element.weekType == Week(date: DateTime.now()).getWeekType())
          .toList();
      _loading = false;
    });
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

  Future<List<ScheduleModel>> getScheduleFromSharedPreferences(
      selectedGroup) async {
    String savedScheduleGroup = await _prefs.then((SharedPreferences prefs) {
      return prefs.getString('savedScheduleGroup') ?? '';
    });
    if (selectedGroup != '' && selectedGroup == savedScheduleGroup) {
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

  Future<void> getClassRoomSchedule(classroom) async {
    await SchedulesRepository()
        .getScheduleByClassroom(classroom)
        .then((newSchedule) => setSchedule(newSchedule));
  }

  @override
  void initState() {
    getSchedule();
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
                  getSchedule();
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
                        padding: widget.screenType ==
                                ScheduleScreenType.classroomSchedule
                            ? 180
                            : 250,
                        schedule: daySchedule,
                      )
                    : Container(
                        margin: EdgeInsets.only(top: 150),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.screenType ==
                                        ScheduleScreenType.mySchedule
                                    ? 'Сегодня у вас нет занятий. Советуем потратить это время на самоподготовку.'
                                    : widget.screenType ==
                                            ScheduleScreenType.classroomSchedule
                                        ? 'Сегодня в данной аудитории нет занятий.'
                                        : 'Сегодня преподаватель не ведет занятия',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
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
              height: widget.screenType == ScheduleScreenType.mySchedule
                  ? 260
                  : 190,
              child: widget.screenType == ScheduleScreenType.mySchedule
                  ? NextLesson()
                  : null,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: widget.screenType != ScheduleScreenType.mySchedule
                    ? 30
                    : 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (widget.screenType == ScheduleScreenType.classroomSchedule)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => context.router.pop(),
                          child: Container(
                              width: 80,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Styles.primaryColor,
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(50),
                                      bottomRight: Radius.circular(50))),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.keyboard_arrow_left,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'Назад',
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ])),
                        ),
                        Gap(20),
                        Text(
                          'Аудитория ${widget.queryParam ?? widget.queryParam}',
                          style: const TextStyle(
                              color: Color(0xFF9498BE),
                              fontWeight: FontWeight.w700,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                widget.screenType == ScheduleScreenType.mySchedule ||
                        widget.screenType ==
                            ScheduleScreenType.classroomSchedule
                    ? CollapsibleCalendar(
                        marginTop:
                            widget.screenType != ScheduleScreenType.mySchedule
                                ? 10
                                : 40,
                        key: _collapsibleCalendarKey,
                        onDayChanged: (selectedDay) {
                          dayChanged(selectedDay);
                        },
                      )
                    : Container(),
              ],
            ),
          )
        ])
      ]),
    );
  }
}
