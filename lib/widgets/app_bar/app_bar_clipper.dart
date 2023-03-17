import 'package:flutter/cupertino.dart';

class AppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
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
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
