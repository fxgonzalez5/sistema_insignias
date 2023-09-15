import 'package:flutter/material.dart';

class RectangularCard extends StatelessWidget {
  final Color color;

  const RectangularCard({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 30),
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(10)
        ),
      ),
    );
  }
}
