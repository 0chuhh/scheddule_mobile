import 'package:flutter/material.dart';
import 'package:schedule_mobile/themes/styles.dart';

typedef OnPressed = void Function(Widget selected, int index);

class CustomButtonGroup extends StatefulWidget {
  const CustomButtonGroup(
      {super.key,
      this.title = '',
      this.style,
      this.direction = Axis.horizontal,
      required this.items,
      this.onPressed});

  final String title;
  final TextStyle? style;
  final Axis direction;
  final List<Widget> items;
  final OnPressed? onPressed;

  @override
  State<CustomButtonGroup> createState() => _CustomButtonGroupState();
}

class _CustomButtonGroupState extends State<CustomButtonGroup> {
  List<bool>? _selectedItems;

  @override
  initState() {
    super.initState();
    // Add listeners to this class
    setState(() {
      _selectedItems = widget.items.map((e) => false).toList();
      _selectedItems![0] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SizedBox(
        height: 30,
        child: LayoutBuilder(builder: (ctx, constraints) {
          return ToggleButtons(
            constraints: BoxConstraints.expand(
                width: (constraints.maxWidth / widget.items.length) - 2),
            direction: widget.direction,
            onPressed: (int index) {
              setState(() {
                for (int i = 0; i < _selectedItems!.length; i++) {
                  _selectedItems![i] = i == index;
                }
              });
              widget.onPressed?.call(widget.items[index], index);
            },
            borderRadius: const BorderRadius.all(Radius.circular(3)),
            selectedBorderColor: Styles.primaryColor,
            selectedColor: Colors.white,
            fillColor: Styles.primaryColor,
            color: Styles.primaryColor,
            isSelected: _selectedItems!,
            children: widget.items,
          );
        }));
  }
}
