// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';

import 'package:badges/models/models.dart';

User userFromMap(String str) => User.fromMap(json.decode(str));

String userToMap(User data) => json.encode(data.toMap());

class User {
    final int id;
    final String nombre;
    final String correo;
    final List<BadgeModel> insignias;
    final List<Coupon> cupones;

    User({
        required this.id,
        required this.nombre,
        required this.correo,
        required this.insignias,
        required this.cupones,
    });

    factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        nombre: json["nombre"],
        correo: json["correo"],
        insignias: json["insignias"] == null ? [] : List<BadgeModel>.from(json["insignias"].map((x) => BadgeModel.fromMap(x))),
        cupones: json["cupones"] == null ? [] : List<Coupon>.from(json["cupones"].map((x) => Coupon.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "correo": correo,
        "insignias": List<BadgeModel>.from(insignias.map((x) => x)),
        "cupones": List<Coupon>.from(cupones.map((x) => x)),
    };
}
