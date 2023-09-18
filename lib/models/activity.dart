import 'package:badges/models/models.dart';

class Activity {
    final int id;
    final String nombre;
    final String descripcion;
    final int total;
    final List<Register> registros;

    Activity({
        required this.id,
        required this.nombre,
        required this.descripcion,
        required this.total,
        required this.registros,
    });

    factory Activity.fromMap(Map<String, dynamic> json) => Activity(
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        total: json["total"],
        registros: List<Register>.from(json["registros"].map((x) => Register.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "total": total,
        "registros": List<dynamic>.from(registros.map((x) => x.toMap())),
    };
}

class Register {
    final int id;
    int progreso;
    final dynamic fechaCompletado;
    final User usuario;

    Register({
        required this.id,
        required this.progreso,
        required this.fechaCompletado,
        required this.usuario,
    });

    factory Register.fromMap(Map<String, dynamic> json) => Register(
        id: json["id"],
        progreso: json["progreso"],
        fechaCompletado: json["fechaCompletado"],
        usuario: User.fromMap(json["usuario"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "progreso": progreso,
        "fechaCompletado": fechaCompletado,
        "usuario": usuario.toMap(),
    };
}