import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schedule_mobile/utils/styles.dart';
import 'package:schedule_mobile/widgets/custom_autocomplete.dart';
import 'package:schedule_mobile/widgets/custom_button_group.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

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
  List<filterBlock> filterBlocks = [];
  List<filterBlock> _data = [];

  @override
  void initState() {
    // TODO: implement initState
    filterBlocks = [
      filterBlock(
        id: 0,
        widget: AnimatedContainer(
          curve: Curves.easeInBack,
          duration: const Duration(milliseconds: 700),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
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
                  list: const ['пи-20', 'пи-21', 'пи-22'],
                  label: 'группа',
                  onTap: (focusNode) {
                    onAutocompleteTap(0);
                  },
                  onTapOutside: () {}),
              const Gap(5),
              ElevatedButton(
                onPressed: () {},
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
      ),
      filterBlock(
        id: 1,
        widget: AnimatedContainer(
          curve: Curves.easeInBack,
          duration: const Duration(milliseconds: 700),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: <Widget>[
              const Text(
                'Найти расписание занятий по преподавателю:',
                style: TextStyle(fontWeight: FontWeight.w500),
                textAlign: TextAlign.left,
              ),
              const Gap(5),
              CustomAutocomplete(
                list: const ['пи-20', 'пи-21', 'пи-22'],
                label: 'Преподаватель',
                onTap: (focusNode) {
                  setState(() {
                    _focusNode = focusNode;
                  });
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
                  onAutocompleteTap(1);
                  // FocusScope.of(context).requestFocus(_focusNode);
                },
              ),
              const Gap(5),
              ElevatedButton(
                onPressed: () {},
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
      ),
      filterBlock(
        id: 2,
        widget: AnimatedContainer(
          curve: Curves.easeInBack,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
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
                list: const [],
                label: 'Аудитория',
                onTap: (focusNode) {
                  onAutocompleteTap(2);
                  // FocusScope.of(context).requestFocus(focusNode);
                },
                onTapOutside: () {
                  unfocusAutocomplete();
                },
              ),
              const Gap(5),
              ElevatedButton(
                onPressed: () {},
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
      )
    ];
    _data = [...filterBlocks];
    super.initState();
  }

  FocusNode _focusNode = new FocusNode();
  void onAutocompleteTap(int index) {
    switch (index) {
      case 0:
        if (filterBlocks.indexOf(
                filterBlocks.firstWhere((element) => element.id == 0)) !=
            0) {
          removeItem(0);
          addItem(0, 0);
          filterBlocks.firstWhere((element) => element.id == 0);
        }
        break;
      case 1:
        if (filterBlocks.indexOf(
                filterBlocks.firstWhere((element) => element.id == 1)) !=
            0) {
          removeItem(1);
          addItem(1, 0);
        }
        break;
      case 2:
        if (filterBlocks.indexOf(
                filterBlocks.firstWhere((element) => element.id == 2)) !=
            0) {
          removeItem(2);
          addItem(2, 0);
        }
        break;
    }
    unfocusAutocomplete();
  }

  void removeItem(int id) {
    final item = filterBlocks.firstWhere((element) => element.id == id);
    final index = filterBlocks.indexOf(item);
    filterBlocks.removeAt(index);
    _animatedListKey.currentState?.removeItem(
        index,
        duration: Duration(milliseconds: 500),
        (context, animation) => SlideTransition(
            position: animation
                .drive(Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))),
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
    setState(() {
      filterBlocks.insert(insertToIndex, item);
      _animatedListKey.currentState?.insertItem(index);
    });
  }

  void unfocusAutocomplete() {
    setState(() {
      selectedIndex = 0;
    });

    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Container(
            margin: const EdgeInsets.only(top: 15),
            height: MediaQuery.of(context).size.height - 200,
            child: AnimatedList(
              key: _animatedListKey,
              initialItemCount: filterBlocks.length,
              itemBuilder: (context, index, animation) {
                return SlideTransition(
                  position: animation.drive(
                    // Tween that slides from right to left.
                    Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0)),
                  ),
                  // Simply display the letter.
                  child: ListTile(
                    title: filterBlocks[index].widget,
                  ),
                );
                ;
              },
            )));
  }
}
