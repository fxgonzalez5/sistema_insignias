// To parse this JSON data, do
//
//     final placesResponseModel = placesResponseModelFromMap(jsonString);

import 'dart:convert';

List<Publicity> publicityFromMap(String str) => List<Publicity>.from(json.decode(str).map((x) => Publicity.fromMap(x)));

String publicityToMap(List<Publicity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Publicity {
    final int id;
    final String imagenUrl;
    final String ruta;

    Publicity({
        required this.id,
        required this.imagenUrl,
        required this.ruta,
    });

    factory Publicity.fromMap(Map<String, dynamic> json) => Publicity(
        id: json["id"],
        imagenUrl: json["imagenUrl"],
        ruta: json["ruta"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "imagenUrl": imagenUrl,
        "ruta": ruta,
    };
}
