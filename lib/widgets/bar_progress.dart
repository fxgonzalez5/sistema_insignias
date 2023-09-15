import 'package:flutter/material.dart';

class BarProgress extends StatefulWidget {
  final double height;
  final double percentage;
  final Color foregroundColor;
  final Color backgroundColor;

  const BarProgress({super.key,
    this.height = 30,
    required this.percentage,
    this.foregroundColor = Colors.green,
    this.backgroundColor = const Color.fromRGBO(224, 224, 224, 1)
  });

  @override
  State<BarProgress> createState() => _BarProgressState();
}

class _BarProgressState extends State<BarProgress> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late double previousPercentage;

  @override
  void initState() {
    previousPercentage = widget.percentage;
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade700,
                  spreadRadius: 10,
                  blurRadius: 10, 
                  offset: const Offset(0, 5),
                ),
              ]
            ),

            child: CustomPaint(
              painter: _MyLineProgress(
                widget.height,
                widget.percentage,
                widget.foregroundColor,
                widget.backgroundColor
              ),
            ),
          );
        },
      ),
    );
  }
}

class _MyLineProgress extends CustomPainter {
  final double height;
  final double percentage;
  final Color foregroundColor;
  final Color backgroundColor;

  _MyLineProgress(this.height, this.percentage, this.foregroundColor, this.backgroundColor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = height
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

      const start = Offset(0, 0);
      final end = Offset(size.width, 0);
      canvas.drawLine(start, end, paint);

      final paint1 = Paint()
      ..strokeWidth = height
      ..color = foregroundColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

      if (percentage != 0) {
        final progress = Offset(size.width * (percentage/100), 0);
        canvas.drawLine(start, progress, paint1);
      }  
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate)  => true;
}
