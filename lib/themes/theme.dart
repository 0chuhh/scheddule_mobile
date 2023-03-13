import 'package:flutter/material.dart';
import 'package:schedule_mobile/themes/styles.dart';

final lightTheme = ThemeData(
    primaryColor: const Color(0xFF606de0),
    fontFamily: 'Montserrat',
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Styles.primaryColor,
        unselectedItemColor: Styles.textColor,
        selectedIconTheme: const IconThemeData(size: 25),
        unselectedIconTheme: const IconThemeData(size: 20),
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed
    )
);
