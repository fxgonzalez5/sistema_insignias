import 'dart:math';

import 'package:flutter/material.dart';

class CircularProgress extends StatelessWidget {
  final double percentage;
  final Color color;

  const CircularProgress({super.key, required this.percentage, this.color = const Color.fromARGB(225, 128, 128, 128)});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: CustomPaint(
        painter: _MiRadialProgress(
          percentage,
          color,
        ),
      ),
    );
  }
}

class _MiRadialProgress extends CustomPainter {
  final double percentage;
  final Color color;

  _MiRadialProgress(this.percentage, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 20
      ..color = color
      ..style = PaintingStyle.stroke;

    const center = Offset(7.5, 7.5);
    final radius = min(7.5, 7.5);

    double arcAngle = 2 * -pi * (percentage / 100);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2, arcAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
