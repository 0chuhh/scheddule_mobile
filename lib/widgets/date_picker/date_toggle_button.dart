import 'package:flutter/material.dart';
import 'package:schedule_mobile/themes/styles.dart';

class DateToggleButton extends StatefulWidget {
  const DateToggleButton({
    Key? key,
    this.isSelected = false,
  }) : super(key: key);

  final bool isSelected;

  @override
  State<DateToggleButton> createState() => _DateToggleButtonState();
}

class _DateToggleButtonState extends State<DateToggleButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Container(
        width: 47,
        height: 47,
        decoration: BoxDecoration(
            color: widget.isSelected ? Styles.accentColor : Colors.transparent,
            border: Border.all(
              color:
              widget.isSelected ? Styles.accentColor : Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(25)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '24',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: widget.isSelected ? Colors.white : Colors.black
              ),
            ),
            Text(
              'Март',
              style: TextStyle(
                fontSize: 8,
                color: widget.isSelected ? Colors.white : Styles.crossColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
