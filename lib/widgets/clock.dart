import 'dart:math';

import 'package:flutter/material.dart';

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFECF6FF),
                  Color(0xFFCADBEB),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF3F6080).withOpacity(.2),
                  blurRadius: 32,
                  offset: Offset(10, 5),
                ),
                BoxShadow(
                  color: Color(0xFFFFFFFF),
                  blurRadius: 32,
                  offset: Offset(-10, -5),
                ),
              ],
            ),
          ),
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFE3F0F8),
                  Color(0xFFEEF5FD),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF3F6080).withOpacity(.2),
                  blurRadius: 32,
                  offset: Offset(40, 20),
                ),
                BoxShadow(
                  color: Color(0xFFFFFFFF),
                  blurRadius: 32,
                  offset: Offset(-20, -10),
                ),
              ],
            ),
          ),
          Container(
            constraints: BoxConstraints.expand(),
            child: CustomPaint(
              painter: ClockPainter(),
            ),
          ),
        ],
      ),
    );
  }
}

//стрелка
class ClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double radius = min(centerX, centerY);
    Offset center = Offset(centerX, centerY);

    Paint secLinePaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    Offset secStartOffset = Offset(
      centerX - radius * cos(0 * pi / 180),
      centerY - radius * cos(0 * pi / 180),
    );
    canvas.drawLine(center, secStartOffset, secLinePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
