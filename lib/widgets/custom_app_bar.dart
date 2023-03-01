import 'package:flutter/material.dart';
import 'package:schedule_mobile/utils/styles.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    required this.body,
    this.height = 80.0,
  }) : super(key: key);

  final Widget body;
  final double height;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size(double.maxFinite, height);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomPaint(
        painter: AppBarPainter(),
        child: _appBarContent(),
      ),
    );
  }

  Widget _appBarContent() {
    return Container(
      height: widget.preferredSize.height,
      width: 400,
      margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        children: [widget.body],
      ),
    );
  }
}

class AppBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;
    Paint paint = Paint();
    Path path = Path();
    paint.shader = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Styles.bgColor,
        Styles.bgColor,
        Colors.white,
      ],
    ).createShader(rect);
    path.lineTo(size.width, size.height * 0.98);
    path.cubicTo(size.width, size.height * 0.98, size.width * 0.81, size.height * 0.93,
        size.width / 2, size.height * 0.98);
    path.cubicTo(
        size.width * 0.19, size.height * 1.03, 0, size.height * 0.98, 0, size.height * 0.98);
    path.cubicTo(0, size.height * 0.98, 0, 0, 0, 0);
    path.cubicTo(0, 0, size.width, 0, size.width, 0);
    path.cubicTo(size.width, 0, size.width, size.height * 0.98, size.width, size.height * 0.98);
    path.cubicTo(size.width, size.height * 0.98, size.width, size.height * 0.98, size.width,
        size.height * 0.98);
    path.close();
    canvas.drawShadow(path, Colors.black38, 5, false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
