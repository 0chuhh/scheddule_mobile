import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:schedule_mobile/repositories/classrooms_repository.dart';
import 'package:schedule_mobile/repositories/groups_repository.dart';
import 'package:schedule_mobile/repositories/lecturers_repository.dart';
import 'package:schedule_mobile/screens/my_schedule_screen.dart';
import 'package:schedule_mobile/themes/styles.dart';
import 'package:schedule_mobile/utils/check_internet_connection.dart';
import 'package:schedule_mobile/utils/show_modal_no_internet_connection.dart';
import 'package:schedule_mobile/widgets/custom_autocomplete.dart';
import 'package:schedule_mobile/widgets/custom_button_group.dart';

import '../routers/router.gr.dart';

class filterBlock {
  int id;
  Widget widget;

  filterBlock({required this.id, required this.widget});
}

class ScheduleSearchCards extends StatefulWidget {
  const ScheduleSearchCards({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ScheduleSearchCardsState();
  }
}

class _ScheduleSearchCardsState extends State<ScheduleSearchCards> {
  final bool fullTimeFormat = false;
  int selectedIndex = 0;
  final _animatedListKey = GlobalKey<AnimatedListState>();
  final _autocomleteByGroupKey = GlobalKey<CustomAutocompleteState>();
  final _autocomleteByLecturerKey = GlobalKey<CustomAutocompleteState>();
  final _autocomleteByClassromKey = GlobalKey<CustomAutocompleteState>();

  List<filterBlock> filterBlocks = [];
  List<filterBlock> _data = [];

  List<String> groups = [];
  List<String> lecturers = [];
  List<String> classroms = [];

  String selectedClassroom = '';
  String selectedGroup = '';
  String selectedLecturer = '';

  String selectedScheduleFormat = 'Очная';
  ScrollController _scrollController = ScrollController();

  /// true - очная; false - заочная
  Future getLecturers() async {
    await LecturersRepository().getLecturers().then((value) {
      lecturers = value.map((e) => e.name).toList();
      if (!mounted) return;
      setState(() {
        _data.insert(
            1,
            filterBlock(
              id: 1,
              widget: AnimatedContainer(
                curve: Curves.easeInBack,
                duration: const Duration(milliseconds: 700),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: <Widget>[
                    const Text(
                      'Найти расписание занятий по преподавателю:',
                      style: TextStyle(fontWeight: FontWeight.w500),
                      textAlign: TextAlign.left,
                    ),
                    const Gap(5),
                    CustomAutocomplete(
                      key: _autocomleteByLecturerKey,
                      list: lecturers,
                      onSelected: (value) {
                        setState(() {
                          selectedLecturer = value;
                        });
                      },
                      label: 'Преподаватель',
                      onTap: (_focusNode) {
                        onAutocompleteTap(1);
                        // FocusScope.of(context).requestFocus(focusNode);
                      },
                      onTapOutside: () {
                        unfocusAutocomplete();
                      },
                    ),
                    const Gap(5),
                    CustomButtonGroup(
                      items: const [
                        Text('Очная форма'),
                        Text('Заочная форма'),
                      ],
                      onPressed: (selected, index) {
                        setState(() {
                          selectedScheduleFormat =
                              index == 0 ? 'Очная' : 'Заочная';
                        });
                      },
                    ),
                    const Gap(5),
                    ElevatedButton(
                      onPressed: () {
                        if (selectedLecturer != '') {
                          context.router.push(ClassRoomScheduleRouter(
                              screenType: ScheduleScreenType.lecturerSchedule,
                              scheduleFormat: selectedScheduleFormat,
                              queryParam: selectedLecturer));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        backgroundColor: Styles.primaryColor,
                        minimumSize: const Size.fromHeight(30),
                        padding: EdgeInsets.zero,
                      ),
                      child: const Text('Найти'),
                    )
                  ],
                ),
              ),
            ));
      });
      addItem(1, 1);
    });
  }

  Future<void> getGroups() async {
    await GroupsRepository().getGroups().then((value) {
      if (!mounted) return;
      setState(() {
        groups = value.map((e) => e.name).toList();
        _data.insert(
            0,
            filterBlock(
              id: 0,
              widget: AnimatedContainer(
                curve: Curves.easeInBack,
                duration: const Duration(milliseconds: 700),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Найти расписание занятий по группе:',
                      style: TextStyle(fontWeight: FontWeight.w500),
                      textAlign: TextAlign.left,
                    ),
                    const Gap(5),
                    CustomAutocomplete(
                        key: _autocomleteByGroupKey,
                        list: groups,
                        label: 'Группа',
                        onSelected: (value) {
                          setState(() {
                            selectedGroup = value;
                          });
                        },
                        onTap: (_focusNode) {
                          onAutocompleteTap(0);
                        },
                        onTapOutside: () {}),
                    const Gap(5),
                    ElevatedButton(
                      onPressed: () {
                        if (selectedGroup != '') {
                          context.router.push(ClassRoomScheduleRouter(
                              screenType: ScheduleScreenType.groupSchedule,
                              queryParam: selectedGroup));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        backgroundColor: Styles.primaryColor,
                        minimumSize: const Size.fromHeight(
                            30), // fromHeight use double.infinity as width and 40 is the height
                      ),
                      child: const Text('Найти'),
                    )
                  ],
                ),
              ),
            ));
      });
      addItem(0, 0);
    });
  }

  Future<void> getClassrooms() async {
    await ClassroomsRepository().getClassrooms().then((value) {
      if (!mounted) return;
      setState(() {
        classroms = value.map((e) => e.classroom).toList();
        _data.insert(
            0,
            filterBlock(
              id: 2,
              widget: AnimatedContainer(
                curve: Curves.easeInBack,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                duration: const Duration(milliseconds: 700),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Найти расписание занятий по аудитории:',
                      style: TextStyle(fontWeight: FontWeight.w500),
                      textAlign: TextAlign.left,
                    ),
                    const Gap(5),
                    CustomAutocomplete(
                      key: _autocomleteByClassromKey,
                      list: classroms,
                      label: 'Аудитория',
                      initValue: selectedClassroom,
                      onSelected: (value) {
                        setState(() {
                          selectedClassroom = value;
                        });
                      },
                      onTap: (_focusNode) {
                        onAutocompleteTap(2);
                        // FocusScope.of(context).requestFocus(focusNode);
                      },
                      onTapOutside: () {
                        unfocusAutocomplete();
                      },
                    ),
                    const Gap(5),
                    ElevatedButton(
                      onPressed: () {
                        if (selectedClassroom != '') {
                          context.router.push(ClassRoomScheduleRouter(
                              screenType: ScheduleScreenType.classroomSchedule,
                              queryParam: selectedClassroom));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        backgroundColor: Styles.primaryColor,
                        minimumSize: const Size.fromHeight(
                            30), // fromHeight use double.infinity as width and 40 is the height
                      ),
                      child: const Text('Найти'),
                    )
                  ],
                ),
              ),
            ));
      });
      addItem(2, 2);
    });
  }

  void init() async {
    if (await checkInternetConnection()) {
      await getGroups();
      await getLecturers().then((value) async => await getClassrooms());
    } else {
      if (context.mounted) {
        showModalNoInternetConnection(context);
      }
    }
  }

  @override
  void initState() {
    init();
    filterBlocks = [];
    _data = [..._data, ...filterBlocks];
    super.initState();
  }

  void onAutocompleteTap(int index) {
    switch (index) {
      case 0:
        if (filterBlocks.indexOf(
                filterBlocks.firstWhere((element) => element.id == 0)) !=
            0) {
          var timer = Timer(const Duration(milliseconds: 250), () {
            removeItem(0);
            addItem(0, 0);
          });
        }
        break;
      case 1:
        if (filterBlocks.indexOf(
                filterBlocks.firstWhere((element) => element.id == 1)) !=
            0) {
          var timer = Timer(const Duration(milliseconds: 250), () {
            removeItem(1);
            addItem(1, 0);
          });
        }
        break;
      case 2:
        if (filterBlocks.indexOf(
                filterBlocks.firstWhere((element) => element.id == 2)) !=
            0) {
          var timer = Timer(const Duration(milliseconds: 250), () {
            removeItem(2);
            addItem(2, 0);
          });
        }
        break;
    }
  }

  void removeItem(int id) {
    final item = filterBlocks.firstWhere((element) => element.id == id);
    final index = filterBlocks.indexOf(item);
    filterBlocks.removeAt(index);
    _animatedListKey.currentState?.removeItem(
        index,
        duration: const Duration(milliseconds: 500),
        (context, animation) => SlideTransition(
            position: animation.drive(Tween(
                begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0))),
            child: Container(
                height: 70,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)))));
  }

  void addItem(int id, int insertToIndex) {
    final item = _data.firstWhere((element) => element.id == id);
    final index = _data.indexOf(item);

    filterBlocks.insert(insertToIndex, item);
    _animatedListKey.currentState?.insertItem(0);
    _scrollController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  void unfocusAutocomplete() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      child: Container(
          margin: const EdgeInsets.only(top: 140),
          child:
              groups.isNotEmpty && lecturers.isNotEmpty && classroms.isNotEmpty
                  ? AnimatedList(
                      controller: _scrollController,
                      key: _animatedListKey,
                      initialItemCount: filterBlocks.length,
                      itemBuilder: (context, index, animation) {
                        return SlideTransition(
                          position: animation.drive(
                            // Tween that slides from right to left.
                            Tween(
                                begin: const Offset(1.0, 1.0),
                                end: const Offset(0.0, 0.0)),
                          ),
                          // Simply display the letter.
                          child: ListTile(
                            title: filterBlocks[index].widget,
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    )),
    );
  }
}
