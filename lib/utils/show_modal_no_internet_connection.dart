import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

void showModalNoInternetConnection(BuildContext context) {
  showDialog(
      routeSettings: const RouteSettings(),
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => WillPopScope(
          child: AlertDialog(
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'OK');
                },
                child: const Text('OK'),
              ),
            ],
            content: Container(
              constraints: BoxConstraints(maxHeight: 300),
              child: Column(
                children: <Widget>[
                  const Text(
                    'Нет соединения с интернетом',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  const Gap(10),
                  const Text(
                      'Пожалуйста, подключите интернет и попробуйте снова'),
                  SvgPicture.asset(
                    'assets/no-connection.svg',
                    width: 150,
                  )
                ],
              ),
            ),
          ),
          onWillPop: () async => false));
}
