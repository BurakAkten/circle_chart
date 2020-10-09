import 'package:flutter/material.dart';
import 'dart:math' as math;

class CirclePainter extends CustomPainter {
  final Color progressColor;
  final Color backgroundColor;
  final double progressNumber;
  final int maxNumber;
  final double fraction;
  final Animation<double> animation;
  Paint _paint;

  CirclePainter(
      {@required this.progressNumber,
      @required this.maxNumber,
      @required this.fraction,
      @required this.animation,
      this.backgroundColor,
      this.progressColor}) {
    _paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 10.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
  }

  void paint(Canvas canvas, Size size) {
    _paint.color = backgroundColor ?? Colors.black12;
    canvas.drawArc(Offset.zero & size, -math.pi * 1.5 + math.pi / 4, (3 * math.pi) / 2, false, _paint);

    _paint.color = progressColor ?? Colors.blue;

    double progressRadians = ((progressNumber / maxNumber) * (3 * math.pi / 2) * (-animation.value));
    double startAngle = (-math.pi * 1.5 + math.pi / 4);

    canvas.drawArc(Offset.zero & size, startAngle, -progressRadians, false, _paint);
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) {
    return oldDelegate.fraction != fraction;
  }
}
