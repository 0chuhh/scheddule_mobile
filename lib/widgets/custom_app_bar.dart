import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.title,
    this.leading,
    this.bottom,
  }) : super(key: key);

  final Widget? title;
  final Widget? leading;
  final Widget? bottom;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size(double.maxFinite, 80);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.preferredSize.height + 100,
      width: widget.preferredSize.width,
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 5)]),
      child: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25 / 2.5),
              child: Row(
                children: [
                  widget.title!,
                ],
              ))),
    );
  }
}
