import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:timelines/timelines.dart';
import 'package:schedule_mobile/models/bell_schedule.dart';
import 'package:schedule_mobile/models/faculty.dart';
import 'package:schedule_mobile/repository/bell_schedule.dart';
import 'package:schedule_mobile/repository/faculty.dart';
import 'package:schedule_mobile/utils/styles.dart';
import 'package:schedule_mobile/widgets/app_bar_painter.dart';

class BellScheduleScreen extends StatefulWidget {
  const BellScheduleScreen({Key? key}) : super(key: key);

  @override
  State<BellScheduleScreen> createState() => _BellScheduleScreenState();
}

class _BellScheduleScreenState extends State<BellScheduleScreen> {
  final List<FacultyModel> _allFaculties = FacultyRepository().getFaculties();
  List<FacultyModel> _foundedFaculties = [];

  @override
  void initState() {
    _foundedFaculties = _allFaculties;
    super.initState();
  }

  void _runFilter(String value) {
    List<FacultyModel> result = [];
    if (value.isEmpty) {
      result = _allFaculties;
    } else {
      result = _allFaculties
          .where((faculty) => faculty.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundedFaculties = result;
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
          itemCount: _foundedFaculties.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: _bellScheduleElevatedButton(
                  _foundedFaculties[index].id,
                  _foundedFaculties[index].name,
                  BellScheduleRepository()
                      .getBellScheduleById(_foundedFaculties[index].bellScheduleId),
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
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                  child: Material(
                    borderRadius: BorderRadius.circular(25),
                    elevation: 5,
                    child: TextField(
                      cursorColor: Styles.primaryColor,
                      cursorRadius: const Radius.circular(2),
                      onChanged: (value) => _runFilter(value),
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Название факультета...',
                        focusColor: Styles.primaryColor,
                        suffixIcon: const Icon(Icons.search),
                        suffixIconColor: Styles.crossColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                )),
          ),
        ),
      ]),
    );
  }

  Widget _bellScheduleElevatedButton(int id, String name, BellScheduleModel bellSchedule) {
    return ElevatedButton(
        onPressed: () {
          FocusScope.of(context).unfocus();
          showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (BuildContext context) {
                return _modalSheet(name, bellSchedule);
              });
        },
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.only(left: 0, right: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                  id.toString(),
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
                child: Text(name),
              ),
            ),
          ],
        )
    );
  }

  Widget _modalSheet(String facultyName, BellScheduleModel bellSchedule) {
    return Wrap(
      children: [
        // BottomSheet
        Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10), topLeft: Radius.circular(10)
                )
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0, bottom: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 4,
                    width: MediaQuery.of(context).size.width * 0.30,
                    decoration: BoxDecoration(
                        color: Styles.crossColor,
                        borderRadius: const BorderRadius.all(Radius.circular(5))),
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
                              facultyName,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const Gap(10),
                  _lessonRow(1, bellSchedule.firstLesson),
                  const Gap(10),
                  _lessonRow(2, bellSchedule.secondLesson),
                  const Gap(10),
                  _lessonRow(3, bellSchedule.thirdLesson),
                  const Gap(15),
                  Center(
                      child: Text(
                    'Большой перерыв ${bellSchedule.bigBreak.start} - ${bellSchedule.bigBreak.end}',
                    style: TextStyle(color: Styles.crossColor, fontWeight: FontWeight.bold),
                  )),
                  const Gap(15),
                  _lessonRow(4, bellSchedule.fourthLesson),
                  const Gap(10),
                  _lessonRow(5, bellSchedule.fifthLesson),
                  const Gap(10),
                  _lessonRow(6, bellSchedule.sixthLesson),
                ],
              ),
            )
        ),
      ],
    );
  }

  Widget _lessonRow(int lessonOrder, TimeRange lesson) {
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
