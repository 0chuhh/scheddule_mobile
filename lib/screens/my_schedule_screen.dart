import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_theme_provider/flutter_theme_provider.dart';
import 'package:gap/gap.dart';
import 'package:schedule_mobile/models/schedule_model.dart';
import 'package:schedule_mobile/repositories/schedules_repository.dart';
import 'package:schedule_mobile/utils/check_internet_connection.dart';
import 'package:schedule_mobile/utils/day_names.dart';
import 'package:schedule_mobile/utils/get_date_from_extremular.dart';
import 'package:schedule_mobile/utils/show_modal_no_internet_connection.dart';
import 'package:schedule_mobile/widgets/collapsible_calendar/collapsible_calendar.dart';
import 'package:schedule_mobile/widgets/app_bar_painter.dart';
import 'package:schedule_mobile/widgets/dark_bar_painter.dart';
import 'package:schedule_mobile/widgets/date_picker/date_picker.dart';
import 'package:schedule_mobile/widgets/date_picker/date_toggle_button.dart';
import 'package:schedule_mobile/widgets/modal_choose_group.dart';
import 'package:schedule_mobile/widgets/schedule_list/schedule_list.dart';
import 'package:schedule_mobile/widgets/week.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../themes/styles.dart';
import '../widgets/next_lesson.dart';
import "package:collection/collection.dart";
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

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
      this.scheduleFormat = 'Очная',
      this.screenType = ScheduleScreenType.mySchedule});
  final bool showCalendar;
  final String scheduleFormat;
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
  GlobalKey<DatePickerState> _DatePickerKey = GlobalKey();
  GlobalKey<NextLessonState> _nextLesson = GlobalKey();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<ScheduleModel> schedule = [];
  bool _loading = false;
  List<ScheduleModel> daySchedule = [];
  String _selectedGroup = '';
  DateTime _selectedDay = DateTime.now();
  List<String> extremularDates = [];
  List<bool> datePickerIsSelected = [];
  void getSchedule() async {
    if (!mounted) return;
    setState(() {
      _loading = true;
    });
    final bool internet = await checkInternetConnection();
    switch (widget.screenType) {
      case ScheduleScreenType.mySchedule:
        getMySchedule().then((value) {
          if ((widget.screenType == ScheduleScreenType.mySchedule &&
              _selectedGroup != '' &&
              schedule.isNotEmpty &&
              schedule.first.form == '0')) {
            _nextLesson.currentState?.stopAlarm();
            _nextLesson.currentState?.notif = false;
            _nextLesson.currentState?.widget.daySchedule = daySchedule;
            _nextLesson.currentState?.widget.schedule = schedule;
            _nextLesson.currentState?.getNearestCouple(DateTime.now());
          }
        });

        break;
      case ScheduleScreenType.classroomSchedule:
        if (internet) {
          getClassRoomSchedule(widget.queryParam);
        } else {
          if (mounted) {
            showModalNoInternetConnection(context);
          }
        }
        break;
      case ScheduleScreenType.groupSchedule:
        if (internet) {
          getGroupSchedule(widget.queryParam);
        } else {
          if (mounted) {
            showModalNoInternetConnection(context);
          }
        }
        break;
      case ScheduleScreenType.lecturerSchedule:
        if (internet) {
          getLecturerSchedule(widget.queryParam, widget.scheduleFormat);
        } else {
          if (mounted) {
            showModalNoInternetConnection(context);
          }
        }
        break;
      default:
        break;
    }
  }

  void setSchedule(List<ScheduleModel> newSchedule) {
    setState(() {
      schedule = newSchedule;
      schedule.sort(((a, b) => a.couple.time.compareTo(b.couple.time)));
      if (schedule.isNotEmpty && schedule.first.form == '0') {
        daySchedule = newSchedule
            .where((element) =>
                element.weekDay.toLowerCase() ==
                    dayNames[DateTime.now().weekday - 1].toLowerCase() &&
                element.weekType == Week(date: DateTime.now()).getWeekType())
            .toList();
        daySchedule.sort(((a, b) => a.couple.time.compareTo(b.couple.time)));
      } else if (schedule.isNotEmpty) {
        daySchedule = schedule;
        daySchedule.sort((a, b) {
          var date = getDateFromExtremular(a.weekDay)![0]
              .compareTo(getDateFromExtremular(b.weekDay)![0]);
          if (date == 0) {
            return a.couple.number.compareTo(b.couple.number);
          }
          return date;
        });
        setState(() {
          extremularDates = daySchedule.map((e) => e.weekDay).toSet().toList();
          datePickerIsSelected = extremularDates
              .map(
                (e) => false,
              )
              .toList();
          datePickerIsSelected[0] = true;
          daySchedule = schedule
              .where(
                (element) => element.weekDay == extremularDates[0],
              )
              .toList();
        });
      }
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
        mySchedule.sort(((a, b) => a.couple.time.compareTo(b.couple.time)));
        return mySchedule;
      }
    }
    return [];
  }

  Future<void> getMySchedule() async {
    final bool internet = await checkInternetConnection();
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
        if (internet) {
          await SchedulesRepository()
              .getSchedulesByGroup(selectedGroupTemp)
              .then((newSchedule) {
            if (!mounted) return;
            saveSchedule(newSchedule, selectedGroupTemp);
            setSchedule(newSchedule);
          });
        } else {
          if (context.mounted) {
            showModalNoInternetConnection(context);
          }
        }
      }
    }
  }

  Future<void> getClassRoomSchedule(classroom) async {
    await SchedulesRepository()
        .getScheduleByClassroom(classroom)
        .then((newSchedule) => setSchedule(newSchedule));
  }

  Future<void> getGroupSchedule(group) async {
    await SchedulesRepository()
        .getSchedulesByGroup(group)
        .then((newSchedule) => setSchedule(newSchedule));
  }

  Future<void> getLecturerSchedule(lecturer, format) async {
    await SchedulesRepository()
        .getScheduleByLecturer(lecturer, format)
        .then((newSchedule) => setSchedule(newSchedule));
  }

  String getLecturerFioInitials(String fullname) {
    String result = '';
    if (fullname.contains(';')) {
      final List<String> lecturers = fullname.split(';');
      lecturers.forEach((element) {
        final List<String> fio = element.trim().split(' ');
        result +=
            '${fio[0]} ${fio[1][0]}.${fio[2][0]}. ${element != lecturers.last ? '; ' : ''}';
      });
      return 'Преподаватли - $result';
    } else {
      final List<String> fio = fullname.trim().split(' ');
      result += '${fio[0]} ${fio[1][0]}.${fio[2][0]}.';
      return 'Преподаватль - $result';
    }
  }

  @override
  void initState() {
    getSchedule();
    Timer(const Duration(milliseconds: 700), () {
      FlutterNativeSplash.remove();
    });
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
      _selectedDay = day;
      WeekType currentWeek = Week(date: day).getWeekType();
      daySchedule = schedule
          .where((element) =>
              element.weekDay.toLowerCase() ==
                  dayNames[day.weekday - 1].toLowerCase() &&
              element.weekType == currentWeek)
          .toList();
      daySchedule.sort(((a, b) => a.couple.number.compareTo(b.couple.number)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
        builder: (context, theme, child) => Scaffold(
              resizeToAvoidBottomInset: false,
              extendBodyBehindAppBar: true,
              backgroundColor: theme.getTheme()?.scaffoldBackgroundColor,
              body: Stack(children: <Widget>[
                Positioned.fill(
                    child: !_loading
                        ? daySchedule.isNotEmpty
                            ? ScheduleList(
                                screenType: widget.screenType,
                                padding: (widget.screenType ==
                                                ScheduleScreenType
                                                    .classroomSchedule ||
                                            widget.screenType ==
                                                ScheduleScreenType
                                                    .groupSchedule ||
                                            widget.screenType ==
                                                ScheduleScreenType
                                                    .lecturerSchedule) &&
                                        schedule.isNotEmpty &&
                                        schedule.first.form == '1'
                                    ? 150
                                    : widget.screenType ==
                                                ScheduleScreenType.mySchedule &&
                                            schedule.isNotEmpty &&
                                            schedule.first.form == '1'
                                        ? 110
                                        : widget.screenType ==
                                                    ScheduleScreenType
                                                        .classroomSchedule ||
                                                widget.screenType ==
                                                    ScheduleScreenType
                                                        .groupSchedule ||
                                                widget.screenType ==
                                                    ScheduleScreenType
                                                        .lecturerSchedule
                                            ? 180
                                            : 250,
                                // : 160,
                                schedule: daySchedule,
                              )
                            : Container(
                                margin: EdgeInsets.only(top: 150),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        schedule.isEmpty
                                            ? 'По данному запросу нет расписания'
                                            : widget.screenType ==
                                                    ScheduleScreenType
                                                        .mySchedule
                                                ? 'Сегодня у вас нет занятий. Советуем потратить это время на самоподготовку.'
                                                : widget.screenType ==
                                                        ScheduleScreenType
                                                            .classroomSchedule
                                                    ? 'Сегодня в данной аудитории нет занятий.'
                                                    : widget.screenType ==
                                                            ScheduleScreenType
                                                                .groupSchedule
                                                        ? 'Сегодня у группы нет занятий'
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
                    painter: theme.getThemeName() == 'Light'
                        ? AppBarPainter()
                        : DarkAppBarPainter(),
                    child: Container(
                      color: Colors.transparent,
                      width: MediaQuery.of(context).size.width,
                      height:
                          widget.screenType == ScheduleScreenType.mySchedule &&
                                  schedule.isNotEmpty &&
                                  schedule.first.form == '0'
                              // ? 260
                              ? 260
                              : schedule.isEmpty
                                  ? 80
                                  : widget.screenType ==
                                              ScheduleScreenType.mySchedule &&
                                          schedule.isNotEmpty &&
                                          schedule.first.form == '1'
                                      ? 120
                                      : ((widget.screenType ==
                                                      ScheduleScreenType
                                                          .groupSchedule ||
                                                  widget.screenType ==
                                                      ScheduleScreenType
                                                          .classroomSchedule ||
                                                  widget.screenType ==
                                                      ScheduleScreenType
                                                          .lecturerSchedule) &&
                                              schedule.isNotEmpty &&
                                              schedule.first.form == '1')
                                          ? 160
                                          : 190,
                      child:
                          widget.screenType == ScheduleScreenType.mySchedule &&
                                  _selectedGroup != '' &&
                                  schedule.isNotEmpty &&
                                  schedule.first.form == '0'
                              ? NextLesson(
                                  key: _nextLesson,
                                  selectedGroup: _selectedGroup,
                                  schedule: schedule,
                                  daySchedule: daySchedule,
                                  selectedDay: _selectedDay,
                                )
                              // ? null
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
                        if (widget.screenType ==
                                ScheduleScreenType.classroomSchedule ||
                            widget.screenType ==
                                ScheduleScreenType.groupSchedule ||
                            widget.screenType ==
                                ScheduleScreenType.lecturerSchedule)
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
                                              bottomRight:
                                                  Radius.circular(50))),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              Icons.keyboard_arrow_left,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              'Назад',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )
                                          ])),
                                ),
                                const Gap(20),
                                Container(
                                  constraints: BoxConstraints(maxWidth: 200),
                                  child: Text(
                                    widget.screenType ==
                                            ScheduleScreenType.classroomSchedule
                                        ? 'Аудитория ${widget.queryParam ?? widget.queryParam}'
                                        : widget.screenType ==
                                                ScheduleScreenType
                                                    .lecturerSchedule
                                            ? getLecturerFioInitials(
                                                widget.queryParam!)
                                            : 'Группа ${widget.queryParam ?? widget.queryParam}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Color(0xFF9498BE),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        schedule.isNotEmpty && schedule.first.form == '0'
                            ? CollapsibleCalendar(
                                marginTop: widget.screenType !=
                                        ScheduleScreenType.mySchedule
                                    ? 10
                                    : 40,
                                key: _collapsibleCalendarKey,
                                onDayChanged: (selectedDay) {
                                  dayChanged(selectedDay);
                                },
                              )
                            : (widget.screenType ==
                                            ScheduleScreenType
                                                .classroomSchedule ||
                                        widget.screenType ==
                                            ScheduleScreenType.groupSchedule ||
                                        widget.screenType ==
                                            ScheduleScreenType
                                                .lecturerSchedule ||
                                        (widget.screenType ==
                                                ScheduleScreenType.mySchedule &&
                                            schedule.isNotEmpty &&
                                            schedule.first.form == '1')) &&
                                    extremularDates.isNotEmpty
                                ? Container(
                                    margin: EdgeInsets.only(
                                        top: widget.screenType ==
                                                ScheduleScreenType.mySchedule
                                            ? 32
                                            : 0),
                                    child: DatePicker(
                                        key: _DatePickerKey,
                                        isSelected: datePickerIsSelected,
                                        onDateChanged: (index) {
                                          setState(() {
                                            for (var i = 0;
                                                i < datePickerIsSelected.length;
                                                i++) {
                                              datePickerIsSelected[i] =
                                                  index == i;
                                            }
                                            daySchedule = schedule
                                                .where((element) =>
                                                    element.weekDay ==
                                                    extremularDates[index])
                                                .toList();
                                          });
                                        },
                                        children: extremularDates),
                                  )
                                : Container(),
                      ],
                    ),
                  )
                ])
              ]),
            ));
  }
}
