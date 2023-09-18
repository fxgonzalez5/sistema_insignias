import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:badges/providers/providers.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blue[900],
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 125),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, -1),
                  blurRadius: 5
                )
              ]      
            ),
            child: const _BodyDrawer(),
          ),

          Positioned(
              top: 100,
              child: Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                  color: const Color(0xff2B3EE3),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3)
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 50,),
              ),
            ),
        ],
      ),
    );
  }
}

class _BodyDrawer extends StatelessWidget {
  const _BodyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final badgeProvider = Provider.of<BadgeProvider>(context);
    final couponProvider = Provider.of<CouponProvider>(context);

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Center(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Text(userProvider.user!.nombre, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
              const SizedBox(height: 10,),
              Text(userProvider.user!.correo, style: const TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.bold),),
              const SizedBox(height: 40,),
            ],
          ),
        ),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('Información personal', style: TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.bold),),
        ),
        ListTile(
          leading: const Icon(Icons.person_pin),
          title: const Text('Perfil', style: TextStyle(fontWeight: FontWeight.w400),),
          onTap: () => Navigator.pushNamed(context, 'profile')
        ),
        ListTile(
          leading: const Icon(Icons.payment),
          title: const Text('ClippPay: Saldos y Tarjetas', style: TextStyle(fontWeight: FontWeight.w400),),
          onTap: () => Navigator.pushNamed(context, '')
        ),

        const SizedBox(height: 10,),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('Recompensas y cupones', style: TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.bold),),
        ),
        ListTile(
          leading: const Icon(Icons.group),
          title: const Text('Código referido', style: TextStyle(fontWeight: FontWeight.w400),),
          onTap: () => Navigator.pushNamed(context, '')
        ),
        ListTile(
          leading: const Icon(Icons.loyalty),
          title: Row(
            children: [
              const Text('Cupones', style: TextStyle(fontWeight: FontWeight.w400),),
              const SizedBox(width: 10,),
              if (couponProvider.newCoupon)
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.blue[900],
                    shape: BoxShape.circle
                  ),
                  child: const Icon(Icons.plus_one_rounded, color: Colors.white,)
                )
            ],
          ),
          onTap: () {
            Navigator.pushNamed(context, 'coupons');
            couponProvider.newCoupon = false;
          }
        ),
        ListTile(
          leading: const Icon(Icons.badge),
          title: Row(
            children: [
              const Text('Insignias', style: TextStyle(fontWeight: FontWeight.w400),),
              const SizedBox(width: 10,),
              if (badgeProvider.newBadge)
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.blue[900],
                    shape: BoxShape.circle
                  ),
                  child: const Icon(Icons.plus_one_rounded, color: Colors.white,)
                )
            ],
          ),
          onTap: () { 
            Navigator.pushNamed(context, 'badge');
            badgeProvider.newBadge = false;
          }
        ),

        const SizedBox(height: 10,),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('Ayuda y soporte', style: TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.bold),),
        ),
        ListTile(
          leading: const Icon(Icons.message),
          title: const Text('Contáctanos', style: TextStyle(fontWeight: FontWeight.w400),),
          onTap: () => Navigator.pushNamed(context, '')
        ),
        ListTile(
          leading: const Icon(Icons.flag),
          title: const Text('Simbología', style: TextStyle(fontWeight: FontWeight.w400),),
          onTap: () => Navigator.pushNamed(context, '')
        ),
        ListTile(
          leading: const Icon(Icons.info_outline_rounded),
          title: const Text('Acerca de Clipp', style: TextStyle(fontWeight: FontWeight.w400),),
          onTap: () => Navigator.pushNamed(context, '')
        ),
        ListTile(
          leading: const Icon(Icons.input_outlined),
          title: const Text('Cerrar sesión', style: TextStyle(fontWeight: FontWeight.w400),),
          onTap: () => Navigator.pushNamed(context, '')
        ),
      ],
    );
  }
}