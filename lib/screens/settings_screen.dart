import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schedule_mobile/utils/styles.dart';
import 'package:schedule_mobile/widgets/app_bar_painter.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool selectedTheme = false;
  final List<String> groups = ['ПИ-20', 'ИВТ-19'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Styles.bgColor,
      body: Column(
        children: [
          // AppBar
          Stack(children: <Widget>[
            CustomPaint(
              painter: AppBarPainter(),
              child: Container(
                margin: const EdgeInsets.only(top: 40),
                width: MediaQuery.of(context).size.width,
                height: 70,
                child: const Text(
                  'Настройки',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFF979CB7), fontSize: 20, fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ]),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          children: const [Icon(Icons.group), Text('Группа')],
                        ),
                        Gap(5),
                        DropdownButtonFormField(
                          focusColor: Styles.accentColor,
                            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                            items: groups.map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              );
                            }).toList(),
                            onChanged: (value) => setState(() {}))
                      ],
                    ),
                  ),
                ),
                const Gap(10),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.dark_mode),
                            Text('Темная тема'),
                            Spacer(),
                            CupertinoSwitch(
                                activeColor: Styles.primaryColor,
                                value: selectedTheme,
                                onChanged: (value) => setState(() {
                                      selectedTheme = value;
                                    }))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
