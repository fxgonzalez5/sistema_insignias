import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:badges/widgets/widgets.dart';
import 'package:badges/providers/providers.dart';
import 'package:badges/helpers/helpers.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  HomeScreen({super.key});

  void _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final badgeProvider = Provider.of<BadgeProvider>(context);
    Provider.of<CouponProvider>(context);
    final publicityProvider = Provider.of<PublicityProvider>(context);
    Future(() async {
      if (badgeProvider.hasStarted) {
        await publicityProvider.getAllPublicities();
        showPublicity(context, publicityProvider.allPublicities[0].imagenUrl, publicityProvider.allPublicities[0].ruta);
        badgeProvider.hasStarted = false;
      }
    });

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.grey[50],
        drawer: const CustomDrawer(),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 20, bottom: 15),
                color: Colors.white,
                child: Column(
                  children: [
                    _Header(_openDrawer),
                    const _Search(),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const _Section('Novedades'),
              const _RectangularCards(),
              const _Section('Servicios Clipp'),
              const SizedBox(
                height: 20,
              ),
              const _CircleButtons()
            ],
          ),
        ));
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onPressed;

  const _Header(
    this.onPressed, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context).user!;

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 15),
          child: GestureDetector(
            onTap: onPressed,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.grey[400],
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xff2B3EE3), width: 3)),
              child: const Icon(
                Icons.person,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Buenos días, ${userProvider.nombre}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              '¿Qué necesitas hoy?',
              style: TextStyle(
                  color: Color(0xff2B3EE3),
                  fontSize: 25,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 30),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xff2B3EE3),
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Image.asset('assets/bandera.png'),
                ),
              ),
              const Text('Loja, EC')
            ],
          ),
        )
      ],
    );
  }
}

class _Search extends StatelessWidget {
  const _Search({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      width: MediaQuery.of(context).size.width * 0.80,
      height: 40,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              offset: Offset(0, 2),
              blurRadius: 2,
            )
          ]),
      child: const Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Buscar en Clipp...',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(
              Icons.search,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String text;

  const _Section(
    this.text, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Text(text,
            style: const TextStyle(
                color: Color(0xff2B3EE3),
                fontSize: 20,
                fontWeight: FontWeight.w500)));
  }
}

class _RectangularCards extends StatelessWidget {
  const _RectangularCards({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: PageView(
          controller: PageController(initialPage: 1, viewportFraction: 0.83),
          children: const [
            RectangularCard(
              color: Colors.purple,
            ),
            RectangularCard(
              color: Colors.blue,
            ),
            RectangularCard(
              color: Colors.amber,
            )
          ]),
    );
  }
}

class _CircleButtons extends StatelessWidget {
  const _CircleButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CircleButton(
            color: Colors.amber.shade700,
            image: Image.asset('assets/taxi.png'),
            text: 'Ktaxi',
            route: 'ktaxi'),
        CircleButton(
            color: Colors.blue.shade200,
            image: Image.asset('assets/eventos.png'),
            text: 'Clipp Eventos',
            route: ''),
        CircleButton(
            color: Colors.green.shade600,
            image: Image.asset('assets/pagos&recargas.png'),
            text: 'Pagos y Recargas',
            route: ''),
      ],
    );
  }
}
