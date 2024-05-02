import 'dart:convert';

import 'data.dart';

Game gameFromJson(String str) => Game.fromJson(json.decode(str));

String gameToJson(Game data) => json.encode(data.toJson());

class Game {
    List<Data> data;

    Game({
        required this.data,
    });

    factory Game.fromJson(Map<String, dynamic> json) => Game(
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

