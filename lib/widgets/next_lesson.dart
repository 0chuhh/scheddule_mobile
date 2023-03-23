import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schedule_mobile/models/schedule_model.dart';
import 'package:schedule_mobile/repositories/schedules_repository.dart';
import 'package:schedule_mobile/routers/router.gr.dart';
import 'package:schedule_mobile/screens/my_schedule_screen.dart';
import 'package:schedule_mobile/utils/date_is_today.dart';
import 'package:schedule_mobile/utils/day_names.dart';
import 'package:schedule_mobile/utils/schedule_item_format.dart';
import 'package:schedule_mobile/widgets/life_cycle_observer.dart';
import 'package:schedule_mobile/widgets/week.dart';
// import 'package:alarm/alarm.dart';

import '../themes/styles.dart';

class NextLesson extends StatefulWidget {
  NextLesson(
      {super.key,
      this.daySchedule = const [],
      this.selectedDay,
      this.schedule = const [],
      this.selectedGroup = ''});

  List<ScheduleModel> daySchedule;
  final DateTime? selectedDay;
  final String selectedGroup;
  List<ScheduleModel> schedule;
  @override
  State<StatefulWidget> createState() {
    return NextLessonState();
  }
}

class NextLessonState extends LifecycleWatcherState<NextLesson> {
  bool notif = false;
  ScheduleModel? nearestScheduleModel;
  Timer? currentCoupleTimer =
      Timer.periodic(const Duration(seconds: 1), (_) {});
  Timer? checkingTimerNearestCouple =
      Timer.periodic(const Duration(seconds: 1), (_) {});
  Duration currentCoupleDuration = const Duration(hours: 0);
  bool today = true;
  bool now = false;
  @override
  void initState() {
    // TODO: implement initState
    widget.schedule.sort((a, b) => a.couple.time.compareTo(b.couple.time));
    widget.daySchedule.sort((a, b) => a.couple.time.compareTo(b.couple.time));
    currentCoupleTimer!.cancel();
    checkingTimerNearestCouple!.cancel();
    getNearestCouple(DateTime.now());
    notif = false;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    checkingTimerNearestCouple!.cancel();
    currentCoupleTimer!.cancel();
    super.dispose();
  }

  void startCheckingTimerNearestCouple() {
    const duration = Duration(seconds: 10);
    setState(() {
      checkingTimerNearestCouple = Timer.periodic(duration, (Timer t) {
        if (!currentCoupleTimer!.isActive) {
          getNearestCouple(widget.selectedDay!);
          print('check');
        } else {
          t.cancel();
          print('cancel');
        }
      });
    });
  }

  void awaitNextCouple() {
    final nextCoupleTime = nearestScheduleModel?.couple.time;
    if (nextCoupleTime!.isAfter(DateTime.now())) {
      final awaitingTime = nextCoupleTime.difference(DateTime.now()).inSeconds;
      print(
          'awaiting next couple time in ${nextCoupleTime.difference(DateTime.now()).inMinutes} minutes...');

      setState(() {
        checkingTimerNearestCouple = Timer(Duration(seconds: awaitingTime), () {
          print('starts new couple time...');
          checkingTimerNearestCouple?.cancel();
          getNearestCouple(DateTime.now());
        });
      });
    }
  }

  void startTimer() {
    currentCoupleTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = currentCoupleDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        currentCoupleTimer!.cancel();
        getNearestCouple(DateTime.now());
      } else {
        currentCoupleDuration = Duration(seconds: seconds);
      }
    });
  }

  List<String> getTimerString() {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final hours = currentCoupleDuration.inHours.remainder(24);
    final minutes =
        currentCoupleDuration.inMinutes.remainder(60) + (hours * 60);
    final seconds = strDigits(currentCoupleDuration.inSeconds.remainder(60));

    return ['$minutes', '$seconds'];
  }

  void setAlarm(DateTime dateTime, String name) async {
    await Alarm.init();
    AlarmSettings alarmSettings;
    if (dateTime.difference(DateTime.now()).inMinutes > 5) {
      alarmSettings = AlarmSettings(
        dateTime: dateTime.subtract(const Duration(minutes: 5)),
        assetAudioPath: 'assets/sample3.mp3',
        loopAudio: true,
        notificationTitle: '5 минут до пары',
        notificationBody: 'Пара ${name} скоро начнется..',
        enableNotificationOnKill: true,
        id: 1,
      );
    } else {
      alarmSettings = AlarmSettings(
        dateTime: dateTime,
        assetAudioPath: 'assets/sample3.mp3',
        loopAudio: true,
        notificationTitle: 'Пара началась',
        notificationBody: 'Пара ${name} уже началась..',
        enableNotificationOnKill: true,
        id: 1,
      );
    }
    await Alarm.setNotificationOnAppKillContent(
        'Переход в тихий режим', 'Приложение пришлет уведомление без звука.');
    if (!Alarm.ringStream.hasListener) {
      Alarm.ringStream.stream.listen((_) {
        navigateToAlarmScreen(alarmSettings);
      });
    }

    await Alarm.set(alarmSettings: alarmSettings);
  }

  Future<void> navigateToAlarmScreen(AlarmSettings alarmSettings) async {
    final res = await showModalBottomSheet<bool?>(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        isDismissible: false,
        builder: (context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: FractionallySizedBox(
                heightFactor: 0.2,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Text(
                        '${alarmSettings.notificationTitle}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 17),
                      ),
                      const Gap(3),
                      Text('${alarmSettings.notificationBody}'),
                      GestureDetector(
                        onTap: () {
                          stopAlarm();
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          color: Styles.primaryColor,
                          margin: const EdgeInsets.only(top: 20),
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(10),
                          child: const Text(
                            'Отключить',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ));
        });
  }

  void stopAlarm() async {
    await Alarm.init();

    if (Alarm.hasAlarm()) {
      await Alarm.stop(1);
    }
    if (!mounted) return;
    setState(() {
      notif = false;
    });
  }

  void getNearestCouple(DateTime day) async {
    var gotElement = false;
    checkingTimerNearestCouple!.cancel();
    currentCoupleTimer!.cancel();
    if (dateIsToday(day)) {
      if (widget.daySchedule.length > 0) {
        widget.daySchedule
            .sort((a, b) => a.couple.time.compareTo(b.couple.time));
        ScheduleModel? todayNearestCouple = getTodayNearestCouple();
        gotElement = todayNearestCouple != null;
        if (!gotElement) {
          getNearestCoupleAfterToday();
          gotElement = true;
        }
      } else if (!gotElement) {
        setState(() {
          today = false;
          now = false;
        });
        getNearestCoupleAfterToday();
        gotElement = true;
      }
    } else {}
  }

  ScheduleModel? getTodayNearestCouple() {
    bool gotElement = false;
    ScheduleModel? result;
    for (var element in widget.daySchedule) {
      if (dayNames[DateTime.now().weekday - 1].toLowerCase() ==
          element.weekDay.toLowerCase()) {
        var currentScheduleModelTime = element.couple.time;
        currentScheduleModelTime = DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            currentScheduleModelTime.hour,
            currentScheduleModelTime.minute);
        if (currentScheduleModelTime.isAfter(DateTime.now())) {
          result = element;
          setState(() {
            nearestScheduleModel = element;
            today = true;
          });
          gotElement = true;
          if (gotElement) {
            awaitNextCouple();
          }
          break;
        } else {
          final DateTime endTimeCouple =
              currentScheduleModelTime.add(const Duration(minutes: 95));

          if (endTimeCouple.isAfter(DateTime.now())) {
            if (endTimeCouple.difference(DateTime.now()).inMinutes <= 95) {
              gotElement = true;

              final Duration timerDuration = Duration(
                  seconds: endTimeCouple.difference(DateTime.now()).inSeconds);
              print(
                  '${endTimeCouple.difference(DateTime.now()).inMinutes} minutes');
              result = element;
              setState(() {
                nearestScheduleModel = element;
                now = true;
                currentCoupleDuration = timerDuration;
              });

              startTimer();

              break;
            }
          }
        }
      }
    }
    if (result == null) {
      setState(() {
        today = false;
        now = false;
      });
    }
    return result;
  }

  void getNearestCoupleAfterToday() {
    setState(() {
      today = false;
      now = false;
    });
    var days = 0;
    var tempSchedule = [];
    var dateTemp = DateTime.now();
    while (tempSchedule.isEmpty) {
      days += 1;
      dateTemp = dateTemp.add(const Duration(days: 1));
      tempSchedule = widget.schedule
          .where((element) =>
              element.weekDay.toLowerCase() ==
                  dayNames[dateTemp.weekday - 1].toLowerCase() &&
              element.weekType == Week(date: dateTemp).getWeekType())
          .toList();
    }

    var currentScheduleModelTime = tempSchedule.first!.couple.time;
    currentScheduleModelTime = DateTime(
        dateTemp.year,
        dateTemp.month,
        dateTemp.day,
        currentScheduleModelTime.hour,
        currentScheduleModelTime.minute);
    setState(() {
      nearestScheduleModel = tempSchedule.first;
      nearestScheduleModel!.couple.time = currentScheduleModelTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Colors.transparent,
        margin: const EdgeInsets.only(top: 140),
        padding: const EdgeInsets.only(left: 20, right: 20),
        alignment: Alignment.bottomCenter,
        child: Column(
          children: nearestScheduleModel == null
              ? []
              : [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        currentCoupleTimer!.isActive
                            ? 'Текущая пара'
                            : 'Ближайшаяя пара',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 5, right: 5, top: 3, bottom: 3),
                        decoration: BoxDecoration(
                            color: Styles.accentColor,
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          getFormatName(nearestScheduleModel?.format),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 10, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  const Gap(10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xffdbdaff),
                                        Color(0x29dbdaff)
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(6)),
                                child: Text(
                                  currentCoupleTimer!.isActive
                                      ? getTimerString()[0]
                                      : nearestScheduleModel!.couple.time.hour >
                                              9
                                          ? nearestScheduleModel!
                                              .couple.time.hour
                                              .toString()
                                          : '0${nearestScheduleModel!.couple.time.hour.toString()}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 25),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const Gap(5),
                              Column(
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                        color: const Color(0xff1e1e1e),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                  ),
                                  const Gap(3),
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                        color: const Color(0xff1e1e1e),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                  )
                                ],
                              ),
                              const Gap(5),
                              Container(
                                alignment: Alignment.center,
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xffdbdaff),
                                        Color(0x29dbdaff)
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(6)),
                                child: Text(
                                  currentCoupleTimer!.isActive
                                      ? getTimerString()[1]
                                      : nearestScheduleModel!
                                                  .couple.time.minute >
                                              9
                                          ? nearestScheduleModel!
                                              .couple.time.minute
                                              .toString()
                                          : '0${nearestScheduleModel!.couple.time.minute.toString()}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 25),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                          const Gap(10),
                        ],
                      ),
                      const Gap(7),
                      Container(
                        alignment: Alignment.topLeft,
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (!today)
                              Text(
                                '${nearestScheduleModel?.couple.time.toString().substring(0, 10)}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 10),
                              ),
                            Text(
                              '${nearestScheduleModel!.name.length > 60 ? '${nearestScheduleModel!.name.substring(0, 60)}...' : nearestScheduleModel?.name}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  height: 1),
                            ),
                            Text(
                              nearestScheduleModel!.lecturer.length > 35
                                  ? '${nearestScheduleModel!.lecturer.substring(0, 35)}...'
                                  : nearestScheduleModel!.lecturer,
                              style: const TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      currentCoupleTimer!.isActive
                          ? Container(
                              width: 95,
                              child: const Text(
                                'До конца пары осталось',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 10),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                if (!notif) {
                                  setAlarm(nearestScheduleModel!.couple.time,
                                      nearestScheduleModel!.name);
                                  setState(() {
                                    notif = true;
                                  });
                                } else {
                                  stopAlarm();
                                  setState(() {
                                    notif = false;
                                  });
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 95,
                                height: 25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: !notif
                                        ? Styles.primaryColor
                                        : const Color.fromARGB(
                                            158, 209, 209, 209)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Transform.rotate(
                                      angle: 6.5,
                                      child: Icon(
                                        Icons.notifications_outlined,
                                        size: 15,
                                        color: !notif
                                            ? Colors.white
                                            : const Color.fromARGB(
                                                255, 104, 103, 103),
                                      ),
                                    ),
                                    Text(
                                      'Напомнить',
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: !notif
                                              ? Colors.white
                                              : const Color.fromARGB(
                                                  255, 68, 68, 68)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                      const Gap(8),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Каф.${nearestScheduleModel?.cathedra}',
                              style: const TextStyle(fontSize: 10),
                            ),
                            Text(
                              'Ауд. ${nearestScheduleModel?.classroom}',
                              style: const TextStyle(fontSize: 10),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
        ),
      ),
    );
  }

  @override
  void onDetached() {
    print('detached');
  }

  @override
  void onInactive() {
    print('inaactive');
  }

  @override
  void onPaused() {
    checkingTimerNearestCouple!.cancel();
    currentCoupleTimer!.cancel();
    print('paused');
  }

  @override
  void onResumed() {
    getNearestCouple(DateTime.now());
  }
}
