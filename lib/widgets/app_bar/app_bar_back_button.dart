import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:schedule_mobile/themes/styles.dart';

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({
    Key? key,
    this.onTap,
    this.text = 'Назад'
  }) : super(key: key);

  final VoidCallback? onTap;
  final String text;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        } else {
          context.router.pop();
        }
      },
      child: Container(
          width: 80,
          height: 30,
          decoration: BoxDecoration(
              color: Styles.primaryColor,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50))),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(
                  Icons.keyboard_arrow_left,
                  color: Colors.white,
                ),
                Text(
                  'Назад',
                  style: TextStyle(color: Colors.white),
                )
              ]
          )
      ),
    );
  }
}
