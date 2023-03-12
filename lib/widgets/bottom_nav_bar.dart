import 'package:flutter/material.dart';


class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.items,
    this.onTap,
  }) : super(key: key);

  final int currentIndex;
  final List<BottomNavigationBarItem> items;
  final void Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 5),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          unselectedLabelStyle: const TextStyle(),
          unselectedFontSize: 12,
          selectedFontSize: 12,
          items: items,
        ),
      ),
    );
  }
}
