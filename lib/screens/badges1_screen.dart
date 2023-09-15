import 'package:flutter/material.dart';

import 'package:badges/widgets/widgets.dart';
import 'package:badges/models/models.dart';

class Badges1Screen extends StatelessWidget {
  final List<BadgeModel> loyaltyBadges;

  const Badges1Screen(this.loyaltyBadges, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const InformationContainer(
            text: 'Completa actividades, consigue insignias y gana beneficios.',
            message:
                'Obtendrás una nueva insignia cada vez que completes una actividad dentro de tu servicio favorito.\n¡Colecciónalas y gana beneficios!',
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              width: MediaQuery.of(context).size.width,
              child: (loyaltyBadges.isNotEmpty)
              ?  Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children:
                  List.generate(
                    loyaltyBadges.length,
                    (index) => _Badge(loyaltyBadges[index])
                  )
                )
              : const Center(
                  child: Text('Por el momento no cuentas con ninguna insignia.', style: TextStyle(fontWeight: FontWeight.w300),)
                ),
            ),
          ),
        ],
      )
    );
  }
}

class _Badge extends StatelessWidget {
  final BadgeModel badge;

  const _Badge(this.badge, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(badge.imagenUrl),
              fit: BoxFit.contain
            )
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: 100,
          child: Text(
            badge.titulo,
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          )
        ),
      ],
    );
  }
}
