import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

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
          Transform.rotate(
            angle: pi / 2,
            child: Container(
              constraints: BoxConstraints.expand(),
              child: CustomPaint(
                painter: ClockPainter(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//??????????????
class ClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    Offset center = Offset(centerX, centerY);
    double radius = min(centerX, centerY);
    double outerRadius = radius - 20;
    double innerRadius = radius - 30;

    Paint hourDashPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    Paint secDashPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 360; i += 30) {
      double x1 = centerX - outerRadius * cos(i * pi / 180);
      double y1 = centerX - outerRadius * sin(i * pi / 180);
      double x2 = centerX - innerRadius * cos(i * pi / 180);
      double y2 = centerX - innerRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), hourDashPaint);
    }

    for (int i = 0; i < 360; i += 3) {
      double x1 = centerX - outerRadius * .95 * cos(i * pi / 180);
      double y1 = centerX - outerRadius * .95 * sin(i * pi / 180);
      double x2 = centerX - innerRadius * cos(i * pi / 180);
      double y2 = centerX - innerRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), secDashPaint);
    }

    DateTime datetime = DateTime.now();

    Paint secLinePaint = Paint()
      ..color = Color(0xFFE81466)
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    Offset secStartOffset = Offset(
      centerX + 20 * cos(datetime.second * 6 * pi / 180),
      centerY + 20 * sin(datetime.second * 6 * pi / 180),
    );

    Offset secEndOffset = Offset(
      centerX - outerRadius * cos(datetime.second * 6 * pi / 180),
      centerY - outerRadius * sin(datetime.second * 6 * pi / 180),
    );

    Paint minLinePaint = Paint()
      ..color = Color(0xFFBEC5D5)
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    Offset minStartOffset = Offset(
      centerX + 20 * cos(datetime.minute * 6 * pi / 180),
      centerY + 20 * sin(datetime.minute * 6 * pi / 180),
    );

    Offset minEndOffset = Offset(
      centerX - outerRadius * .6 * cos(datetime.minute * 6 * pi / 180),
      centerY - outerRadius * .6 * sin(datetime.minute * 6 * pi / 180),
    );

    Paint hourLinePaint = Paint()
      ..color = Color(0xFF222E63)
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    Offset hourEndOffset = Offset(
      centerX - outerRadius * .4 * cos(datetime.hour * 6 * pi / 180),
      centerY - outerRadius * .4 * sin(datetime.hour * 6 * pi / 180),
    );

    Offset hourStartOffset = Offset(
      centerX + 20 * cos(datetime.hour * 6 * pi / 180),
      centerY + 20 * sin(datetime.hour * 6 * pi / 180),
    );

    Paint centerCirclePaint = Paint()..color = Color(0xFFE81466);

    canvas.drawLine(minStartOffset, minEndOffset, minLinePaint);
    canvas.drawLine(hourStartOffset, hourEndOffset, hourLinePaint);
    canvas.drawLine(secStartOffset, secEndOffset, secLinePaint);
    canvas.drawCircle(center, 5, centerCirclePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
