import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final Color color;
  final Image image;
  final String text;
  final String route;

  const CircleButton({super.key, required this.color, required this.text, required this.route, required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Column(
        children: [
          Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              color: color, shape: BoxShape.circle
            ),
            child: Center(
              child: image,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 80,
            height: 35,
            child: Text(
              text, 
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )
          )
        ],
      ),
    );
  }
}
