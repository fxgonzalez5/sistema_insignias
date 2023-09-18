import 'package:flutter/material.dart';

class InformationContainer extends StatelessWidget {
  final String text;
  final String message;

  const InformationContainer({
    super.key, required this.text, required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.65,
            child: Text(text, style: const TextStyle(color: Colors.grey),)
          ),

          Tooltip(
            key: tooltipkey,
            margin: const EdgeInsets.symmetric(horizontal:50),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            textStyle: const TextStyle(color: Colors.black, height: 1.5),
            message: message,
            child:  IconButton(
              onPressed: () => tooltipkey.currentState?.ensureTooltipVisible(),
              icon: const Icon(Icons.info_outline, color: Colors.grey,),
              splashColor: Colors.transparent,
            )
          )
        ],
      ),
    );
  }
}