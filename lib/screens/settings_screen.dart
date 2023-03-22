import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schedule_mobile/themes/styles.dart';
import 'package:schedule_mobile/utils/check_internet_connection.dart';
import 'package:schedule_mobile/utils/show_modal_no_internet_connection.dart';
import 'package:schedule_mobile/widgets/app_bar_painter.dart';
import 'package:schedule_mobile/widgets/custom_autocomplete.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repositories/groups_repository.dart';

typedef OnGroupChanged = void Function();

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key, required this.onGroupChanged})
      : super(key: key);
  final OnGroupChanged onGroupChanged;
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool selectedTheme = false;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> _selectedGroup;
  List<String> groups = [];
  @override
  void initState() {
    super.initState();

    getGroups();
    _selectedGroup = _prefs.then((SharedPreferences prefs) {
      return prefs.getString('myGroup') ?? '';
    });
  }

  void getGroups() async {
    if (await checkInternetConnection()) {
      await GroupsRepository().getGroups().then((value) {
        if (!mounted) return;

        setState(() {
          groups = value.map((e) => e.name).toList();
        });
      });
    } else {
      if (context.mounted) {
        showModalNoInternetConnection(context);
      }
    }
  }

  void setGroup(value) async {
    final SharedPreferences prefs = await _prefs;
    if (!mounted) return;
    widget.onGroupChanged.call();
    setState(() {
      _selectedGroup = prefs.setString('myGroup', value).then((bool success) {
        return value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Styles.bgColor,
      body: Container(
        width: double.infinity,
        child: Column(
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
                        color: Color(0xFF979CB7),
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                children: [
                  Material(
                    elevation: 3,
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: FutureBuilder<String>(
                            future: _selectedGroup,
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.none:
                                case ConnectionState.waiting:
                                  return const CircularProgressIndicator();
                                case ConnectionState.active:
                                case ConnectionState.done:
                                  if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return CustomAutocomplete(
                                      label: 'Группа',
                                      list: groups,
                                      initValue: snapshot.data ?? '',
                                      onSelected: (value) {
                                        setGroup(value);
                                      },
                                    );
                                  }
                              }
                            }),
                      ),
                    ),
                  ),
                  const Gap(10),
                  Material(
                    elevation: 3,
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            const Text(
                              'О приложении',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Text(
                              'Официальное приложение Расписание ЗабГУ. \n  Разработка ОРиВ ПО УИТ.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'версия 0.3.0',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Styles.crossColor),
                            ),
                            const Text(
                              '(прототип)',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 241, 84, 84),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Theme
                  // Material(
                  //   elevation: 3,
                  //   borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  //   child: Container(
                  //     width: MediaQuery.of(context).size.width,
                  //     decoration: const BoxDecoration(
                  //         color: Colors.white,
                  //         borderRadius:
                  //             BorderRadius.all(Radius.circular(15.0))),
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(15),
                  //       child: Column(
                  //         children: [
                  //           Row(
                  //             children: [
                  //               const Icon(Icons.dark_mode),
                  //               const Text('Темная тема'),
                  //               const Spacer(),
                  //               CupertinoSwitch(
                  //                   activeColor: Styles.primaryColor,
                  //                   value: selectedTheme,
                  //                   onChanged: (value) => setState(() {
                  //                         selectedTheme = value;
                  //                       }))
                  //             ],
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
