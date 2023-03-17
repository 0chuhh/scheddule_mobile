import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schedule_mobile/themes/styles.dart';
import 'package:schedule_mobile/widgets/app_bar/app_bar_clipper.dart';
import 'package:schedule_mobile/widgets/app_bar/app_bar_painter.dart';

class CurvedAppBar extends StatelessWidget {
  const CurvedAppBar({
    Key? key,
    this.leading,
    this.title,
    this.flexSpace
  }) : super(key: key);

  final Widget? leading;
  final Widget? title;
  final Widget? flexSpace;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: AppBarPainter(),
      child: ClipPath(
        clipper: AppBarClipper(),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Styles.bgColor,
                Colors.white,
              ],
            ),
          ),
          width: double.infinity,
          child: SafeArea(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Center(child: title),
                      leading ?? Container(),
                    ],
                  ),
                  const Gap(5),
                  flexSpace ?? Container(),
                  const Gap(10),
                ],
              )
          ),
        ),
      ),
    );
  }
}
