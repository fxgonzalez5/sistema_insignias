// To parse this JSON data, do
//
//     final badgeModel = badgeModelFromMap(jsonString);

import 'dart:convert';

import 'package:badges/models/models.dart';

List<BadgeModel> badgeModelFromMap(String str) => List<BadgeModel>.from(json.decode(str).map((x) => BadgeModel.fromMap(x)));

String badgeModelToMap(List<BadgeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class BadgeModel {
    final int id;
    final String titulo;
    final String descripcion;
    final String imagenUrl;
    final String tipo;
    Activity? actividad;

    BadgeModel({
        required this.id,
        required this.titulo,
        required this.descripcion,
        required this.imagenUrl,
        required this.tipo,
        this.actividad,
    });

    factory BadgeModel.fromMap(Map<String, dynamic> json) => BadgeModel(
        id: json["id"],
        titulo: json["titulo"],
        descripcion: json["descripcion"],
        imagenUrl: json["imagenUrl"],
        tipo: json["tipo"],
        actividad: json["actividad"] == null ? null : Activity.fromMap(json["actividad"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "titulo": titulo,
        "descripcion": descripcion,
        "imagenUrl": imagenUrl,
        "tipo": tipo,
        "actividad": actividad?.toMap(),
    };
}


