import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:badges/widgets/widgets.dart';
import 'package:badges/models/models.dart';
import 'package:badges/providers/providers.dart';


class Badges2Screen extends StatelessWidget {
  final List<BadgeModel> badgesEarned;

  const Badges2Screen(this.badgesEarned, {super.key});

  @override
  Widget build(BuildContext context) {
    final badgeProvider = Provider.of<BadgeProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          const InformationContainer(
            text: 'Interactúa en Clipp y ¡desbloquéalas todas!',
            message: 'Familiarízate a través de las interacciones dentro de Clipp, gana insignias y conviértete en un experto.',
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            width: MediaQuery.of(context).size.width,
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              children: List.generate(
                badgeProvider.usabilityBadges.length, 
                (index) => _Badge(
                  badgeProvider.usabilityBadges[index],
                  (badgesEarned.isNotEmpty && (index < badgesEarned.length) && (badgeProvider.usabilityBadges[index].id == badgesEarned[index].id)) 
                    ? true
                    : false
                )
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
  final bool visibility;

  const _Badge(this.badge, this.visibility, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final BoxDecoration decoration = (visibility) 
    ? BoxDecoration(
        image: DecorationImage(image: NetworkImage(badge.imagenUrl))
      )
    : BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
        border: Border.all(width: 5, color: Colors.grey.shade400)
      );

    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: decoration
        ),

        const SizedBox(height: 10,),

        SizedBox(
          width: 100,
          child: Text( 
            (visibility)
            ? badge.titulo
            : 'Bloqueada', 
            style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,
          )
        ),
      ],
    );
  }
}