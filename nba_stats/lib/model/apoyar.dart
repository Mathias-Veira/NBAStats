// To parse this JSON data, do
//
//     final apoyar = apoyarFromJson(jsonString);

import 'dart:convert';

Apoyar apoyarFromJson(String str) => Apoyar.fromJson(json.decode(str));

String apoyarToJson(Apoyar data) => json.encode(data.toJson());

class Apoyar {
    int idUsuario;
    int idEquipo;

    Apoyar({
        required this.idUsuario,
        required this.idEquipo,
    });

    factory Apoyar.fromJson(Map<String, dynamic> json) => Apoyar(
        idUsuario: json["idUsuario"],
        idEquipo: json["idEquipo"],
    );

    Map<String, dynamic> toJson() => {
        "idUsuario": idUsuario,
        "idEquipo": idEquipo,
    };
}
