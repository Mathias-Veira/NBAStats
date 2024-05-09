import 'dart:convert';

List<Equipo> equipoFromJson(String str) => List<Equipo>.from(json.decode(str).map((x) => Equipo.fromJson(x)));

String equipoToJson(List<Equipo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Equipo {
    int idEquipo;
    String nombreEquipo;
    String ciudadEquipo;
    String abreviacionEquipo;
    String imagenEquipo;
    String conferenciaEquipo;
    String divisionEquipo;
    int puestoConferencia;
    int puestoDivision;
    int nVictorias;
    int nDerrotas;
    double porcentajeVictorias;

    Equipo({
        required this.idEquipo,
        required this.nombreEquipo,
        required this.ciudadEquipo,
        required this.abreviacionEquipo,
        required this.imagenEquipo,
        required this.conferenciaEquipo,
        required this.divisionEquipo,
        required this.puestoConferencia,
        required this.puestoDivision,
        required this.nVictorias,
        required this.nDerrotas,
        required this.porcentajeVictorias,
    });

    factory Equipo.fromJson(Map<String, dynamic> json) => Equipo(
        idEquipo: json["idEquipo"],
        nombreEquipo: json["nombreEquipo"],
        ciudadEquipo: json["ciudadEquipo"],
        abreviacionEquipo: json["abreviacionEquipo"],
        imagenEquipo: json["imagenEquipo"],
        conferenciaEquipo: json["conferenciaEquipo"],
        divisionEquipo: json["divisionEquipo"],
        puestoConferencia: json["puestoConferencia"],
        puestoDivision: json["puestoDivision"],
        nVictorias: json["nVictorias"],
        nDerrotas: json["nDerrotas"],
        porcentajeVictorias: json["porcentajeVictorias"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "idEquipo": idEquipo,
        "nombreEquipo": nombreEquipo,
        "ciudadEquipo": ciudadEquipo,
        "abreviacionEquipo": abreviacionEquipo,
        "imagenEquipo": imagenEquipo,
        "conferenciaEquipo": conferenciaEquipo,
        "divisionEquipo": divisionEquipo,
        "puestoConferencia": puestoConferencia,
        "puestoDivision": puestoDivision,
        "nVictorias": nVictorias,
        "nDerrotas": nDerrotas,
        "porcentajeVictorias": porcentajeVictorias,
    };
}

enum ConferenciaEquipo {
    EAST,
    WEST
}

final conferenciaEquipoValues = EnumValues({
    "East": ConferenciaEquipo.EAST,
    "West": ConferenciaEquipo.WEST
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
