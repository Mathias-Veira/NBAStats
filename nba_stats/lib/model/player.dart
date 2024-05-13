import 'dart:convert';

List<Jugador> jugadorFromJson(String str) => List<Jugador>.from(json.decode(str).map((x) => Jugador.fromJson(x)));

String jugadorToJson(List<Jugador> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Jugador {
    int idJugador;
    int idEquipo;
    String nombreJugador;
    String apellidoJugador;
    String posicionJugador;
    String alturaJugador;
    int pesoJugador;
    int numeroCamiseta;
    String universidad;
    String procedenciaJugador;
    int anioDraft;
    int rondaDraft;
    int numeroDraft;

    Jugador({
        required this.idJugador,
        required this.idEquipo,
        required this.nombreJugador,
        required this.apellidoJugador,
        required this.posicionJugador,
        required this.alturaJugador,
        required this.pesoJugador,
        required this.numeroCamiseta,
        required this.universidad,
        required this.procedenciaJugador,
        required this.anioDraft,
        required this.rondaDraft,
        required this.numeroDraft,
    });

    factory Jugador.fromJson(Map<String, dynamic> json) => Jugador(
        idJugador: json["idJugador"]?? json["id"],
        idEquipo: json["idEquipo"]??json[ "team_id"],
        nombreJugador: json["nombreJugador"]?? json["first_name"],
        apellidoJugador: json["apellidoJugador"] ?? json["last_name"],
        posicionJugador: json["posicionJugador"] ?? json[ "position"],
        alturaJugador: json["alturaJugador"] ?? json[ "height"],
        pesoJugador: int.parse(json["pesoJugador"] ?? json["weight"]) ,
        numeroCamiseta: int.parse(json["numeroCamiseta"] ?? json["jersey_number"]),
        universidad: json["universidad"] ?? json["college"],
        procedenciaJugador: json["procedenciaJugador"] ?? json["country"],
        anioDraft: json["anioDraft"] ?? json[ "draft_year"]?? 0,
        rondaDraft: json["rondaDraft"] ?? json["draft_round"]?? 0,
        numeroDraft: json["numeroDraft"] ?? json["draft_number"] ?? 0,
    );

    Map<String, dynamic> toJson() => {
        "idJugador": idJugador,
        "idEquipo": idEquipo,
        "nombreJugador": nombreJugador,
        "apellidoJugador": apellidoJugador,
        "posicionJugador": posicionJugador,
        "alturaJugador": alturaJugador,
        "pesoJugador": pesoJugador,
        "numeroCamiseta": numeroCamiseta,
        "universidad": universidad,
        "procedenciaJugador": procedenciaJugador,
        "anioDraft": anioDraft,
        "rondaDraft": rondaDraft,
        "numeroDraft": numeroDraft,
    };
}
