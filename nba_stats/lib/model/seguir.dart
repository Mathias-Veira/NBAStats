// To parse this JSON data, do
//
//     final seguir = seguirFromJson(jsonString);

import 'dart:convert';

Seguir seguirFromJson(String str) => Seguir.fromJson(json.decode(str));

String seguirToJson(Seguir data) => json.encode(data.toJson());

class Seguir {
    int idUsuario;
    int idJugador;

    Seguir({
        required this.idUsuario,
        required this.idJugador,
    });

    factory Seguir.fromJson(Map<String, dynamic> json) => Seguir(
        idUsuario: json["idUsuario"],
        idJugador: json["idJugador"],
    );

    Map<String, dynamic> toJson() => {
        "idUsuario": idUsuario,
        "idJugador": idJugador,
    };
}
