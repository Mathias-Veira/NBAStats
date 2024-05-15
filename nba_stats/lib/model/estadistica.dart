import 'dart:convert';

import 'stat.dart';

Estadistica promedioFromJson(String str) =>
    Estadistica.fromJson(json.decode(str));

String promedioToJson(Estadistica data) => json.encode(data.toJson());

class Estadistica {
  List<Stat> data;

  Estadistica({
    required this.data,
  });

  factory Estadistica.fromJson(Map<String, dynamic> json) => Estadistica(
        data: List<Stat>.from(json["data"].map((x) => Stat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
