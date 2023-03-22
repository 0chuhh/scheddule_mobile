import 'package:flutter/material.dart';
import 'package:schedule_mobile/widgets/date_picker/date_toggle_button.dart';

typedef OnDateChanged = void Function(int index);

class DatePicker extends StatefulWidget {
  const DatePicker({
    Key? key,
    required this.children,
    this.onDateChanged,
  }) : super(key: key);

  final List<DateToggleButton> children;
  final OnDateChanged? onDateChanged;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  late List<bool> isSelected =
      List.generate(widget.children.length, (_) => _ == 0 ? true : false);

  void _onPressed(int index) {
    setState(() {
      for (int buttonIndex = 0;
          buttonIndex < isSelected.length;
          buttonIndex++) {
        isSelected[buttonIndex] = buttonIndex == index ? true : false;
      }
    });

    widget.onDateChanged?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 110,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
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
                    isSelected: isSelected,
                    fillColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    children: List.generate(widget.children.length, (index) {
                      return DateToggleButton(
                        date: widget.children[index].date,
                        month: widget.children[index].month,
                        isSelected: isSelected[index],
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
