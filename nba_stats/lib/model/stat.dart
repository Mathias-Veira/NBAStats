import 'dart:convert';
import 'dart:math';

import 'data.dart';
import 'equipo.dart';
import 'game.dart';
import 'player.dart';
import 'team.dart';

class Stat {
  int id;
  String? min;
  int? fgm;
  int? fga;
  double? fgPct;
  int? fg3M;
  int? fg3A;
  double? fg3Pct;
  int? ftm;
  int? fta;
  double? ftPct;
  int? oreb;
  int? dreb;
  int? reb;
  int? ast;
  int? stl;
  int? blk;
  int? turnover;
  int? pf;
  int? pts;
  late Jugador player;
  late Team team;
  late Data game;

  Stat({
    required this.id,
    required this.min,
    required this.fgm,
    required this.fga,
    required this.fgPct,
    required this.fg3M,
    required this.fg3A,
    required this.fg3Pct,
    required this.ftm,
    required this.fta,
    required this.ftPct,
    required this.oreb,
    required this.dreb,
    required this.reb,
    required this.ast,
    required this.stl,
    required this.blk,
    required this.turnover,
    required this.pf,
    required this.pts,
    required this.player,
    required this.team,
    required this.game,
  });

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
        id: json["id"],
        min: json["min"] ?? "0",
        fgm: json["fgm"] ?? 0,
        fga: json["fga"] ?? 0,
        fgPct: json["fg_pct"]?.toDouble() * 100 ?? 0.0,
        fg3M: json["fg3m"] ?? 0,
        fg3A: json["fg3a"] ?? 0,
        fg3Pct: json["fg3_pct"]?.toDouble() * 100 ?? 0.0,
        ftm: json["ftm"] ?? 0,
        fta: json["fta"] ?? 0,
        ftPct: json["ft_pct"]?.toDouble() * 100 ?? 0.0,
        oreb: json["oreb"] ?? 0,
        dreb: json["dreb"] ?? 0,
        reb: json["reb"] ?? 0,
        ast: json["ast"] ?? 0,
        stl: json["stl"] ?? 0,
        blk: json["blk"] ?? 0,
        turnover: json["turnover"] ?? 0,
        pf: json["pf"] ?? 0,
        pts: json["pts"] ?? 0,
        player: Jugador.fromJson(json["player"]),
        team: Team.fromJson(json["team"]),
        game: Data.fromJsonStats(json["game"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "min": min,
        "fgm": fgm,
        "fga": fga,
        "fg_pct": fgPct,
        "fg3m": fg3M,
        "fg3a": fg3A,
        "fg3_pct": fg3Pct,
        "ftm": ftm,
        "fta": fta,
        "ft_pct": ftPct,
        "oreb": oreb,
        "dreb": dreb,
        "reb": reb,
        "ast": ast,
        "stl": stl,
        "blk": blk,
        "turnover": turnover,
        "pf": pf,
        "pts": pts,
        "player": player.toJson(),
        "team": team.toJson(),
        "game": game.toJson(),
      };
}
