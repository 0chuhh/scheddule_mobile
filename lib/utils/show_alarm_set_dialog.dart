import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void showAlarmSetDialog(BuildContext context) {
  showDialog(
    routeSettings: const RouteSettings(),
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'OK');
          },
          child: const Text('OK'),
        ),
      ],
      content: Container(
        constraints: const BoxConstraints(maxHeight: 240),
        child: Column(
          children: <Widget>[
            const Text(
              'Приложение пришлет вам уведомление о начале пары.',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            SvgPicture.asset(
              'assets/push-notification.svg',
              width: 150,
            )
          ],
        ),
      ),
    ),
  );
}
