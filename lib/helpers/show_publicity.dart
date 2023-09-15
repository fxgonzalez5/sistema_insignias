import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

showPublicity(BuildContext context, String url, String route) {
  if (Platform.isIOS) {
    return showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => CupertinoAlertDialog(
        content: ClipRRect(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
          child: Image.network(url)
        ),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, route);
            },
            child: const Text('Completar Acción'),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      content: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
        child: Image.network(url)
      ),
      contentPadding: const EdgeInsets.all(0),
      actions: [
        MaterialButton(
          elevation: 5,
          textColor: Colors.blue,
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, route);
          },
          child: const Text('Completar Acción'),
        ),
        MaterialButton(
          elevation: 5,
          textColor: Colors.blue,
          onPressed: () => Navigator.pop(context),
          child: const Text('Cerrar'),
        ),
      ],
    ),
  );
}