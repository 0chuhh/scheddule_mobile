import 'package:flutter/material.dart';
import 'package:schedule_mobile/themes/styles.dart';

ThemeData lightTheme = ThemeData(
    primaryColor: Styles.primaryColor,
    fontFamily: 'Montserrat',
    brightness: Brightness.light,
    scaffoldBackgroundColor: Styles.bgColor,
    cardColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll(Colors.white),
            foregroundColor: MaterialStatePropertyAll(Styles.textColor))),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Styles.primaryColor,
        unselectedItemColor: Styles.textColor,
        selectedIconTheme: const IconThemeData(size: 25),
        unselectedIconTheme: const IconThemeData(size: 20),
        type: BottomNavigationBarType.fixed));

ThemeData darkTheme = ThemeData(
    primaryColor: Styles.primaryColor,
    fontFamily: 'Montserrat',
    brightness: Brightness.dark,
    cardColor: const Color(0xFF3D3D3D),
    scaffoldBackgroundColor: Styles.darkBgColor,
    switchTheme: SwitchThemeData(
        thumbColor: MaterialStatePropertyAll(Styles.primaryColor),
        trackColor: MaterialStatePropertyAll(Styles.primaryColor)),
    elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Color(0xFF3D3D3D)))),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        selectedIconTheme: IconThemeData(size: 25, color: Colors.white),
        unselectedIconTheme: IconThemeData(size: 20, color: Color(0xFF94A3B8)),
        backgroundColor: Color(0xFF3A3A3A),
        type: BottomNavigationBarType.fixed));
