import 'package:flutter/material.dart';
import 'package:schedule_mobile/utils/get_date_from_extremular.dart';
import 'package:schedule_mobile/widgets/date_picker/date_toggle_button.dart';

typedef OnDateChanged = void Function(int index);

class DatePicker extends StatefulWidget {
  const DatePicker({
    Key? key,
    required this.children,
    this.onDateChanged,
    required this.isSelected,
  }) : super(key: key);

  final List<String> children;
  final OnDateChanged? onDateChanged;
  final List<bool> isSelected;

  @override
  State<DatePicker> createState() => DatePickerState();
}

class DatePickerState extends State<DatePicker> {
  void _onPressed(int index) {
    widget.onDateChanged?.call(index);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 70,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Material(
          borderRadius: BorderRadius.circular(50),
          elevation: 5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: ToggleButtons(
                    renderBorder: false,
                    onPressed: _onPressed,
                    isSelected: widget.isSelected,
                    fillColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    children: widget.children
                        .map((e) => DateToggleButton(
                              isSelected:
                                  widget.isSelected[widget.children.indexOf(e)],
                              date: getDateFromExtremular(e)![0].day.toString(),
                              month: getDateFromExtremular(e)![1].substring(
                                  getDateFromExtremular(e)![1].length - 3),
                            ))
                        .toList()),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Wdiget {}
