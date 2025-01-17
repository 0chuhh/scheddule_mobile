import 'package:flutter/material.dart';
import 'package:schedule_mobile/themes/styles.dart';

class AppBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, size) {
    var rect = Offset.zero & size;
    Paint paint = Paint();
    Path path = Path();
    paint.shader = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Styles.bgColor,
        Colors.white,
      ],
    ).createShader(rect);
    path.lineTo(size.width, size.height * 0.98);
    path.cubicTo(size.width, size.height * 0.98, size.width * 0.81,
        size.height * 0.93, size.width / 2, size.height * 0.98);
    path.cubicTo(size.width * 0.19, size.height * 1.03, 0, size.height * 0.98,
        0, size.height * 0.98);
    path.cubicTo(0, size.height * 0.98, 0, 0, 0, 0);
    path.cubicTo(0, 0, size.width, 0, size.width, 0);
    path.cubicTo(size.width, 0, size.width, size.height * 0.98, size.width,
        size.height * 0.98);
    path.cubicTo(size.width, size.height * 0.98, size.width, size.height * 0.98,
        size.width, size.height * 0.98);
    path.close();
    canvas.drawShadow(path, Colors.black38, 5, false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
