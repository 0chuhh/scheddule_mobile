import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schedule_mobile/widgets/search_text_field.dart';
import 'package:timelines/timelines.dart';
import 'package:schedule_mobile/models/bell_schedule_model.dart';
import 'package:schedule_mobile/models/campus_model.dart';
import 'package:schedule_mobile/repositories/bell_schedules_repository.dart';
import 'package:schedule_mobile/repositories/faculties_repository.dart';
import 'package:schedule_mobile/themes/styles.dart';
import 'package:schedule_mobile/widgets/app_bar_painter.dart';

class BellScheduleScreen extends StatefulWidget {
  const BellScheduleScreen({Key? key}) : super(key: key);

  @override
  State<BellScheduleScreen> createState() => _BellScheduleScreenState();
}

class _BellScheduleScreenState extends State<BellScheduleScreen> {
  final List<CampusModel> _allCampuses = CampusesRepository().getCampuses();
  List<CampusModel> _foundedCampuses = [];

  @override
  void initState() {
    _foundedCampuses = _allCampuses;
    super.initState();
  }

  void _runFilter(String value) {
    List<CampusModel> result = [];
    if (value.isEmpty) {
      result = _allCampuses;
    } else {
      result = _allCampuses
          .where((campus) =>
              campus.address.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundedCampuses = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Styles.bgColor,
      body: Stack(children: <Widget>[
        ListView.builder(
          padding: const EdgeInsets.only(top: 150, bottom: 10),
          itemCount: _foundedCampuses.length,
          itemBuilder: (context, index) {
            return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: _ElevatedButton(
                  campusId: _foundedCampuses[index].id,
                  campusAddress: _foundedCampuses[index].address,
                  bellSchedule: BellSchedulesRepository().getBellScheduleById(
                      _foundedCampuses[index].bellScheduleId),
                ));
          },
        ),
        CustomPaint(
          painter: AppBarPainter(),
          child: SafeArea(
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                  child: SearchTextField(
                    hintText: 'Адрес корпуса...',
                    onChanged: _runFilter,
                  ),
                )),
          ),
        ),
      ]),
    );
  }
}

class _ElevatedButton extends StatelessWidget {
  const _ElevatedButton({
    Key? key,
    required this.campusId,
    required this.campusAddress,
    required this.bellSchedule,
  }) : super(key: key);

  final int campusId;
  final String campusAddress;
  final BellScheduleModel bellSchedule;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          FocusScope.of(context).unfocus();
          showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (BuildContext context) {
                return _ModalSheet(
                    campusAddress: campusAddress, bellSchedule: bellSchedule);
              });
        },
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.only(left: 0, right: 20),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            minimumSize: Size(MediaQuery.of(context).size.width, 50),
            maximumSize: Size(MediaQuery.of(context).size.width, 50),
            backgroundColor: Colors.white,
            foregroundColor: Styles.textColor),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: Styles.primaryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  campusId.toString(),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(campusAddress),
              ),
            ),
          ],
        ));
  }
}

class _ModalSheet extends StatelessWidget {
  const _ModalSheet({
    Key? key,
    required this.campusAddress,
    required this.bellSchedule,
  }) : super(key: key);

  final String campusAddress;
  final BellScheduleModel bellSchedule;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        // BottomSheet
        Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 5.0, bottom: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 4,
                    width: MediaQuery.of(context).size.width * 0.30,
                    decoration: BoxDecoration(
                        color: Styles.crossColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                  ),
                  const Gap(10),
                  Row(
                    children: [
                      const Icon(Icons.calendar_month_outlined),
                      const Gap(5),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Расписание звонков'),
                            Text(
                              campusAddress,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const Gap(10),
                  _LessonRow(lessonOrder: 1, lesson: bellSchedule.firstLesson),
                  const Gap(10),
                  _LessonRow(lessonOrder: 2, lesson: bellSchedule.secondLesson),
                  const Gap(10),
                  _LessonRow(lessonOrder: 3, lesson: bellSchedule.thirdLesson),
                  const Gap(15),
                  Center(
                      child: Text(
                    'Большой перерыв ${bellSchedule.bigBreak.start} - ${bellSchedule.bigBreak.end}',
                    style: TextStyle(
                        color: Styles.crossColor, fontWeight: FontWeight.bold),
                  )),
                  const Gap(15),
                  _LessonRow(lessonOrder: 4, lesson: bellSchedule.fourthLesson),
                  const Gap(10),
                  _LessonRow(lessonOrder: 5, lesson: bellSchedule.fifthLesson),
                  const Gap(10),
                  _LessonRow(lessonOrder: 6, lesson: bellSchedule.sixthLesson),
                ],
              ),
            )),
      ],
    );
  }
}

class _LessonRow extends StatelessWidget {
  const _LessonRow({
    Key? key,
    required this.lessonOrder,
    required this.lesson,
  }) : super(key: key);

  final int lessonOrder;
  final TimeRange lesson;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('${lessonOrder.toString()} пара'),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: DashedLineConnector(
            thickness: 1,
            gap: 2,
            dash: 3,
            direction: Axis.horizontal,
            color: Styles.crossColor,
          ),
        )),
        Text('${lesson.start} - ${lesson.end}'),
      ],
    );
  }
}
