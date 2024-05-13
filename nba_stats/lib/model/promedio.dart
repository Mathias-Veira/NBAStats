import 'dart:convert';

import 'average.dart';

Promedio promedioFromJson(String str) => Promedio.fromJson(json.decode(str));

String promedioToJson(Promedio data) => json.encode(data.toJson());

class Promedio {
    List<Average> data;

    Promedio({
        required this.data,
    });

    factory Promedio.fromJson(Map<String, dynamic> json) => Promedio(
        data: List<Average>.from(json["data"].map((x) => Average.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}