import 'team.dart';

class Data {
  int id;
  DateTime date;
  int season;
  String status;
  int period;
  String time;
  bool postseason;
  int homeTeamScore;
  int visitorTeamScore;
  Team homeTeam;
  Team visitorTeam;

  Data({
    required this.id,
    required this.date,
    required this.season,
    required this.status,
    required this.period,
    required this.time,
    required this.postseason,
    required this.homeTeamScore,
    required this.visitorTeamScore,
    required this.homeTeam,
    required this.visitorTeam,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        season: json["season"],
        status: json["status"],
        period: json["period"],
        time: json["time"],
        postseason: json["postseason"],
        homeTeamScore: json["home_team_score"],
        visitorTeamScore: json["visitor_team_score"],
        homeTeam: Team.fromJson(json["home_team"]),
        visitorTeam: Team.fromJson(json["visitor_team"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "season": season,
        "status": status,
        "period": period,
        "time": time,
        "postseason": postseason,
        "home_team_score": homeTeamScore,
        "visitor_team_score": visitorTeamScore,
        "home_team": homeTeam.toJson(),
        "visitor_team": visitorTeam.toJson(),
      };
}
