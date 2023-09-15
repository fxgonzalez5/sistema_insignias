import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:badges/providers/providers.dart';

showAlert(BuildContext context,
    {int? number,
    required String text,
    required url,
    bool isUsability = false}) {
  final badgeProvider = Provider.of<BadgeProvider>(context, listen: false);

  if (Platform.isIOS) {
    return showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => CupertinoAlertDialog(
        title: Text(
          (!isUsability)
              ? '¡Felicidades, has completado $number ${text.toLowerCase()}!'
              : '¡Felicidades, has ${text.toLowerCase()}!',
          textAlign: TextAlign.center,
        ),
        content: SizedBox(
          height: 150,
          child: Column(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(url), fit: BoxFit.cover)),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Has obtenido una nueva insignia',
                style: TextStyle(color: Colors.grey[600]),
              )
            ],
          ),
        ),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'badge');
            },
            child: const Text('Ir a "Colección"'),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              badgeProvider.newBadge = true;
              Navigator.pop(context);
            },
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
      title: Text(
        (!isUsability)
            ? '¡Felicidades, has completado $number ${text.toLowerCase()}!'
            : '¡Felicidades, has ${text.toLowerCase()}!',
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        height: 150,
        child: Column(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(url), fit: BoxFit.cover)),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Has obtenido una nueva insignia',
              style: TextStyle(color: Colors.grey[600]),
            )
          ],
        ),
      ),
      actions: [
        MaterialButton(
          elevation: 5,
          textColor: Colors.blue,
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, 'badge');
          },
          child: const Text('Ir a "Colección"'),
        ),
        MaterialButton(
          elevation: 5,
          textColor: Colors.blue,
          onPressed: () {
            badgeProvider.newBadge = true;
            Navigator.pop(context);
          },
          child: const Text('Cerrar'),
        ),
      ],
    ),
  );
}
