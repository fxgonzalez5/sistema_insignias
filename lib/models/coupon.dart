// To parse this JSON data, do
//
//     final coupon = couponFromMap(jsonString);

import 'dart:convert';

List<Coupon> couponFromMap(String str) => List<Coupon>.from(json.decode(str).map((x) => Coupon.fromMap(x)));

String couponToMap(List<Coupon> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Coupon {
    final int id;
    final String titulo;
    final String descripcion;
    final String cupon;
    final String imagenUrl;
    final String descuento;
    final DateTime fecha;

    Coupon({
        required this.id,
        required this.titulo,
        required this.descripcion,
        required this.cupon,
        required this.imagenUrl,
        required this.descuento,
        required this.fecha,
    });

    factory Coupon.fromMap(Map<String, dynamic> json) => Coupon(
        id: json["id"],
        titulo: json["titulo"],
        descripcion: json["descripcion"],
        cupon: json["cupon"],
        imagenUrl: json["imagenUrl"],
        descuento: json["descuento"],
        fecha: DateTime.parse(json["fecha"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "titulo": titulo,
        "descripcion": descripcion,
        "cupon": cupon,
        "imagenUrl": imagenUrl,
        "descuento": descuento,
        "fecha": "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
    };
}
