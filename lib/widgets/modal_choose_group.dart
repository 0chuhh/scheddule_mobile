import 'package:flutter/material.dart';
import 'package:schedule_mobile/widgets/custom_autocomplete.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repositories/groups_repository.dart';

typedef OnAccept = void Function();

class ModalChooseGroup extends StatefulWidget {
  ModalChooseGroup({super.key, this.onAccept});
  final OnAccept? onAccept;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ModalChooseGroupState();
  }
}

class _ModalChooseGroupState extends State<ModalChooseGroup> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> _selectedGroup;
  List<String> groups = [];
  @override
  void initState() {
    // TODO: implement initState
    getGroups();
    _selectedGroup = _prefs.then((SharedPreferences prefs) {
      return prefs.getString('myGroup') ?? '';
    });
    super.initState();
  }

  void getGroups() async {
    await GroupsRepository().getGroups().then((value) {
      if (!mounted) return;

      setState(() {
        groups = value.map((e) => e.name).toList();
      });
    });
  }

  void setGroup(value) async {
    final SharedPreferences prefs = await _prefs;
    if (!mounted) return;

    setState(() {
      _selectedGroup = prefs.setString('myGroup', value).then((bool success) {
        return value.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      title: const Text('Выберите группу'),
      content: Container(
        height: 70,
        child: FutureBuilder<String>(
            future: _selectedGroup,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
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
      actions: <Widget>[
        TextButton(
          onPressed: () {
            widget.onAccept?.call();

            Navigator.pop(context, 'OK');
          },
          child: const Text('Выбрать'),
        ),
      ],
    );
  }
}
