import 'package:flutter/material.dart';
import 'package:flutter_theme_provider/flutter_theme_provider.dart';
import 'package:schedule_mobile/themes/styles.dart';
import 'package:provider/provider.dart';

class DateToggleButton extends StatefulWidget {
  const DateToggleButton({
    Key? key,
    this.isSelected = false,
    required this.date,
    required this.month,
  }) : super(key: key);

  final bool isSelected;
  final String date;
  final String month;

  @override
  State<DateToggleButton> createState() => _DateToggleButtonState();
}

class _DateToggleButtonState extends State<DateToggleButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
        builder: (context, theme, child) => Padding(
              padding: const EdgeInsets.all(2),
              child: Container(
                width: 37,
                height: 37,
                decoration: BoxDecoration(
                    color: widget.isSelected
                        ? Styles.accentColor
                        : Colors.transparent,
                    border: Border.all(
                      color: widget.isSelected
                          ? Styles.accentColor
                          : Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(25)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.date,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: widget.isSelected
                              ? Colors.white
                              : theme.getThemeName() == 'Light'
                                  ? Colors.black
                                  : Styles.crossColor),
                    ),
                    Text(
                      widget.month,
                      style: TextStyle(
                        fontSize: 8,
                        color: widget.isSelected
                            ? Colors.white
                            : Styles.crossColor,
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
