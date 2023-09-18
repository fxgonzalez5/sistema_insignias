import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:badges/widgets/widgets.dart';
import 'package:badges/providers/providers.dart';


class ActivitiesScreen extends StatelessWidget {

  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final badgeProvider = Provider.of<BadgeProvider>(context);

    return Scaffold(
      appBar: AppBar(
          title: const Text('Actividades'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),

      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const _ActivitiesProgress(),

          for (var index = 0; index < badgeProvider.badges.length; index++)
            _ActivityCard(
              index: index,
              name: badgeProvider.badges[index].actividad!.nombre,
              description: badgeProvider.badges[index].actividad!.descripcion,
              total: badgeProvider.badges[index].actividad!.total,
              progress: badgeProvider.badges[index].actividad!.registros[0].progreso,
              url: badgeProvider.badges[index].imagenUrl,
            ),
            
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
            child: Text('Las actividades se actualizarán según avances en las actuales; complétalas todas, obtén insignias y gana beneficios.', style: TextStyle(color: Colors.grey),),
          ),
        ],
      )
   );
  }
}

class _ActivitiesProgress extends StatelessWidget {
  const _ActivitiesProgress({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final couponProvider = Provider.of<CouponProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 75),
      child: Column(
        children: [
          SizedBox(
            height: 30,
            child: Stack(
              alignment: Alignment.center,
              children: [
                BarProgress(percentage: (100/3) * couponProvider.badgesEarned,),
          
                if (couponProvider.badgesEarned == 3)
                GestureDetector(
                  onTap: () async {
                    couponProvider.newCoupon = true;
                    couponProvider.badgesEarned = 0;
                    await couponProvider.couponAssignment(context, couponProvider.allCoupons[0].id);
                  },
                  child: Text('Cupón descuento ${couponProvider.allCoupons[0].descuento}%', style: const TextStyle(color: Colors.white),)
                )
              ],
            ),
          ),
          
          const SizedBox(height: 15,),
          
          (couponProvider.badgesEarned != 3)
            ? Text('¡Llevas ${couponProvider.badgesEarned}/3 insignias para ganar tu beneficio!', style: const TextStyle(color: Colors.grey, fontSize: 12.5),)
            : const Text('Canjéalo ahora', style: TextStyle(color: Colors.grey, fontSize: 12.5),),
        ],
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final int index;
  final String name;
  final String description;
  final int total;
  final int progress;
  final String url;

  const _ActivityCard({
    super.key, required this.index, required this.name, required this.description, required this.total, required this.progress, required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Actividad N.${index+1}', style: const TextStyle(color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w500),),
          const SizedBox(height: 20,),
    
          Container(
            width: double.infinity,
            height: 120,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 3,
                  blurRadius: 5, 
                  offset: Offset(0, 3),
                ),
              ]
            ),

            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)
                    ),
                    const SizedBox(height: 5,),
                    SizedBox(
                      width: 200,
                      child: Text(
                        'Llevas $progress/$total ${description.toLowerCase()} para tu siguiente insignia.', 
                        style: const TextStyle(fontSize: 13),
                      )
                    )
                  ],
                ),

                const Spacer(),

                _BadgeProgress(url, total, progress,)
              ],
            ),
          )
        ]
      )
    );
  }
}

class _BadgeProgress extends StatelessWidget {
  final String url;
  final int total;
  final int completed;

  const _BadgeProgress(this.url, this.total, this.completed,{
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(url))
          ),
        ),

        CircularProgress(percentage: (100/total) * (total - completed))
      ],
    );
  }
}