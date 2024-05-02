class Team {
    int id;
    String conference;
    String division;
    String city;
    String name;
    String fullName;
    String abbreviation;

    Team({
        required this.id,
        required this.conference,
        required this.division,
        required this.city,
        required this.name,
        required this.fullName,
        required this.abbreviation,
    });

    factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json["id"],
        conference: json["conference"],
        division: json["division"],
        city: json["city"],
        name: json["name"],
        fullName: json["full_name"],
        abbreviation: json["abbreviation"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "conference": conference,
        "division": division,
        "city": city,
        "name": name,
        "full_name": fullName,
        "abbreviation": abbreviation,
    };
}