import 'package:badges/models/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:badges/providers/providers.dart';

class ValidateCellPhoneScreen extends StatelessWidget {
  const ValidateCellPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Validación de Celular'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Column(
          children: [
            const Text('Escribe el número de celular, presiona el botón de continuar y te enviaremos un mensaje de texto con un código de verificación.', 
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),

            const SizedBox(height: 100,),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  'assets/ecuador.png',
                  height: 30,
                ),
                const SizedBox(
                  width: 50,
                  child: Text('+593', style: TextStyle(fontSize: 13), textAlign: TextAlign.center,)
                ),
                SizedBox(
                  width: 250,
                  child: TextFormField(
                    controller: textController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Celular'
                    ),
                  )
                ),
              ],
            ),

            const SizedBox(height: 50,),

            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue.shade900,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () async {
                    textController.clear();
                    Navigator.pushNamed(context, 'home');
                    final badgeProvider = Provider.of<BadgeProvider>(context, listen: false);
                    final BadgeModel badge = badgeProvider.usabilityBadges.where((element) => element.titulo == 'Telefono').first;
                    await badgeProvider.completedActivityUsability(context, badge.id);
                  },
                  icon: const Icon(Icons.arrow_forward_rounded),
                  color: Colors.white,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
              ),
            )
          ],
        ),
      ),
   );
  }
}