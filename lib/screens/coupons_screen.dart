import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:badges/providers/providers.dart';
import 'package:badges/models/models.dart';

class CouponsScreen extends StatelessWidget {
  const CouponsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final couponProvider = Provider.of<CouponProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cupones'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _CouponInput(),
            const SizedBox(height: 35,),
            const Text('Mis Cupones', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
            const SizedBox(height: 20,),
            Expanded(
              child: ListView.builder(
                itemCount: couponProvider.allCoupons.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: _CouponCard(coupon: couponProvider.allCoupons[index],),
                  );
                },
              ),
            )
          ],
        ),
      )
   );
  }
}

class _CouponInput extends StatelessWidget {
  const _CouponInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(Icons.local_activity_outlined, color: Colors.blue[900],),

        SizedBox(
          width: 200,
          child: TextFormField(
            initialValue: 'Ingresa un cupón...',
          )
        ),

        ElevatedButton(
          onPressed: (){}, 
          style: ButtonStyle(
            padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 25)),
            backgroundColor: MaterialStatePropertyAll(Colors.blue[900]),
            elevation: const MaterialStatePropertyAll(3),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          child: const Text('Validar', style: TextStyle(fontWeight: FontWeight.w400),),
        )
      ],
    );
  }
}

class _CouponCard extends StatelessWidget {
  final Coupon coupon;

  const _CouponCard({
    super.key, required this.coupon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 2,
            blurRadius: 3, 
            offset: Offset(0, 2),
          ),
        ]
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(coupon.imagenUrl), fit: BoxFit.cover)
            ),
          ),
          Container(
            width: 2,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            color: Colors.grey.shade400,
          ),

          _Description(coupon: coupon),
        ],
      )
    );
  }
}

class _Description extends StatelessWidget {
  final Coupon coupon;

  const _Description({
    super.key,
    required this.coupon,
  });

  @override
  Widget build(BuildContext context) {
    String formatDate(DateTime dateTime) {
      return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
    }

    String formatTime(DateTime dateTime) {
      return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(coupon.titulo),
        
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            const Text('%', style: TextStyle(fontSize: 15),),
            const SizedBox(width: 5,),
            Text(coupon.descuento, style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),
          ],
        ),
    
        Text(coupon.descripcion),
    
        Row(
          children: [
            const Icon(Icons.schedule, size: 15),
            const SizedBox(width: 5,),
            const Text('Vence:', style: TextStyle(fontWeight: FontWeight.bold),),
            const SizedBox(width: 3,),
            Text('${formatDate(coupon.fecha)} ${formatTime(coupon.fecha)}', style: const TextStyle(fontSize: 16),),
          ],
        ),
    
        const SizedBox()
      ],
    );
  }
}
