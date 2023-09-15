import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:badges/providers/providers.dart';


class KtaxiScreen extends StatelessWidget {
  const KtaxiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          _BackgroundImage(),
          _BackButton(),
          _ActionButtons(),
          _LocationButton(),
          _ActivitiesButton(),
          _LocationBox()
        ],
      )
   );
  }
}

class _LocationBox extends StatelessWidget {
  const _LocationBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: 270,
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0, 0),
              blurRadius: 5,
            )
          ]
        ),

        child: const _LocationInformation(),
      ),
    );
  }
}

class _LocationInformation extends StatelessWidget {
  const _LocationInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context).user!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('¡Hola, ${userProvider.nombre}!', style: const TextStyle(color: Colors.green, fontSize: 16),),
        const SizedBox(height: 10,),
        const Text('¿Estás aquí?', style: TextStyle(fontWeight: FontWeight.bold),),
        const SizedBox(height: 5,),
        const _AddressBox(text: 'Buscando dirección...',),
        const SizedBox(height: 5,),
        const Text('¿A dónde quieres ir? (Opcional)', style: TextStyle(fontWeight: FontWeight.bold),),
        const SizedBox(height: 5,),
        const _AddressBox(text: 'Ingrese un destino',),
        const SizedBox(height: 10,),
        ElevatedButton(
          onPressed: () async {
            final badgeProvider = Provider.of<BadgeProvider>(context, listen: false);
            final badge = badgeProvider.badges.where((element) => element.actividad!.nombre == 'Pedido de taxis').first;
            await badgeProvider.updateProgresActivity(context, badge.actividad!);
          }, 
          style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll(Colors.green),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))
          ),
          child: const SizedBox(
            width: double.infinity,
            height: 50,
            child: Center(child: Text('Solicitar taxi', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),))
          )
        )
      ],
    );
  }
}

class _AddressBox extends StatelessWidget {
  final String text;

  const _AddressBox({
    super.key, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on_outlined, color: Colors.grey,),
          const SizedBox(width: 15,),
          Text(text, style: const TextStyle(color: Colors.grey),),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, color: Colors.grey,),
        ],
      ),
    );
  }
}

class _ActivitiesButton extends StatelessWidget {
  const _ActivitiesButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 300,
      right: 0,
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, 'activities'),
        child: Container(
          width: 65,
          height: 35,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.horizontal(left: Radius.circular(5))
          ),
          child: const Icon(Icons.check)
        ),
      ),
    );
  }
}

class _LocationButton extends StatelessWidget {
  const _LocationButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 350,
      right: 0,
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.only(right: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.my_location),
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 60,
      left: (MediaQuery.of(context).size.width - 150) / 2 ,
      width: 150,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.calendar_today_rounded),
            Icon(Icons.schedule),
            Icon(Icons.star_border),
          ],
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 60,
      left: 10,
      child: Container(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
      ),
    );
  }
}

class _BackgroundImage extends StatelessWidget {
  const _BackgroundImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/Mapa.png',),
          fit: BoxFit.cover
        ),
      ),
    );
  }
}