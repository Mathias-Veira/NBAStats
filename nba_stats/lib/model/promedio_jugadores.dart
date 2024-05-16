// To parse this JSON data, do
//
//     final promedioJugadores = promedioJugadoresFromJson(jsonString);

import 'dart:convert';

List<PromedioJugadores> promedioJugadoresFromJson(String str) => List<PromedioJugadores>.from(json.decode(str).map((x) => PromedioJugadores.fromJson(x)));

String promedioJugadoresToJson(List<PromedioJugadores> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PromedioJugadores {
    int idEstadistica;
    int idJugador;
    double puntosPorPartido;
    double asistenciasPorPartido;
    double perdidasPorPartido;
    double faltasPorPartido;
    double tirosIntentados;
    double tirosConvertidos;
    double tirosLibresIntentados;
    double tirosLibresConvertidos;
    double triplesIntentados;
    double triplesConvertidos;
    double rebotesPorPartido;
    double rebotesOfensivosPorPartido;
    double rebotesDefensivosPorPartido;
    double robosPorPartido;
    double taponesPorPartido;
    double porcentajeTirosDeCampo;
    double porcentajeTriples;
    double porcentajeTirosLibres;
    String minutosJugados;
    int partidosJugados;

    PromedioJugadores({
        required this.idEstadistica,
        required this.idJugador,
        required this.puntosPorPartido,
        required this.asistenciasPorPartido,
        required this.perdidasPorPartido,
        required this.faltasPorPartido,
        required this.tirosIntentados,
        required this.tirosConvertidos,
        required this.tirosLibresIntentados,
        required this.tirosLibresConvertidos,
        required this.triplesIntentados,
        required this.triplesConvertidos,
        required this.rebotesPorPartido,
        required this.rebotesOfensivosPorPartido,
        required this.rebotesDefensivosPorPartido,
        required this.robosPorPartido,
        required this.taponesPorPartido,
        required this.porcentajeTirosDeCampo,
        required this.porcentajeTriples,
        required this.porcentajeTirosLibres,
        required this.minutosJugados,
        required this.partidosJugados,
    });

    factory PromedioJugadores.fromJson(Map<String, dynamic> json) => PromedioJugadores(
        idEstadistica: json["idEstadistica"],
        idJugador: json["idJugador"],
        puntosPorPartido: json["puntosPorPartido"]?.toDouble(),
        asistenciasPorPartido: json["asistenciasPorPartido"]?.toDouble(),
        perdidasPorPartido: json["perdidasPorPartido"]?.toDouble(),
        faltasPorPartido: json["faltasPorPartido"]?.toDouble(),
        tirosIntentados: json["tirosIntentados"]?.toDouble(),
        tirosConvertidos: json["tirosConvertidos"]?.toDouble(),
        tirosLibresIntentados: json["tirosLibresIntentados"]?.toDouble(),
        tirosLibresConvertidos: json["tirosLibresConvertidos"]?.toDouble(),
        triplesIntentados: json["triplesIntentados"]?.toDouble(),
        triplesConvertidos: json["triplesConvertidos"]?.toDouble(),
        rebotesPorPartido: json["rebotesPorPartido"]?.toDouble(),
        rebotesOfensivosPorPartido: json["rebotesOfensivosPorPartido"]?.toDouble(),
        rebotesDefensivosPorPartido: json["rebotesDefensivosPorPartido"]?.toDouble(),
        robosPorPartido: json["robosPorPartido"]?.toDouble(),
        taponesPorPartido: json["taponesPorPartido"]?.toDouble(),
        porcentajeTirosDeCampo: json["porcentajeTirosDeCampo"]?.toDouble(),
        porcentajeTriples: json["porcentajeTriples"]?.toDouble(),
        porcentajeTirosLibres: json["porcentajeTirosLibres"]?.toDouble(),
        minutosJugados: json["minutosJugados"],
        partidosJugados: json["partidosJugados"],
    );

    Map<String, dynamic> toJson() => {
        "idEstadistica": idEstadistica,
        "idJugador": idJugador,
        "puntosPorPartido": puntosPorPartido,
        "asistenciasPorPartido": asistenciasPorPartido,
        "perdidasPorPartido": perdidasPorPartido,
        "faltasPorPartido": faltasPorPartido,
        "tirosIntentados": tirosIntentados,
        "tirosConvertidos": tirosConvertidos,
        "tirosLibresIntentados": tirosLibresIntentados,
        "tirosLibresConvertidos": tirosLibresConvertidos,
        "triplesIntentados": triplesIntentados,
        "triplesConvertidos": triplesConvertidos,
        "rebotesPorPartido": rebotesPorPartido,
        "rebotesOfensivosPorPartido": rebotesOfensivosPorPartido,
        "rebotesDefensivosPorPartido": rebotesDefensivosPorPartido,
        "robosPorPartido": robosPorPartido,
        "taponesPorPartido": taponesPorPartido,
        "porcentajeTirosDeCampo": porcentajeTirosDeCampo,
        "porcentajeTriples": porcentajeTriples,
        "porcentajeTirosLibres": porcentajeTirosLibres,
        "minutosJugados": minutosJugados,
        "partidosJugados": partidosJugados,
    };
}
