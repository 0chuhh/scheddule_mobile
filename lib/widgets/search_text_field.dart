import 'package:flutter/material.dart';
import 'package:schedule_mobile/themes/styles.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    Key? key,
    this.hintText,
    this.onChanged
  }) : super(key: key);

  final String? hintText;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(25),
      elevation: 5,
      child: TextField(
        cursorColor: Theme.of(context).primaryColor,
        cursorRadius: const Radius.circular(2),
        onChanged: onChanged,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          focusColor: Theme.of(context).primaryColor,
          suffixIcon: const Icon(Icons.search),
          suffixIconColor: Styles.crossColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
