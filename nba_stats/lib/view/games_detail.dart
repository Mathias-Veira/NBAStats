import 'package:flutter/material.dart';

import '../controller/api_request.dart';
import '../model/promedio.dart';

class game_detail extends StatefulWidget {
  final int idPartido;
  const game_detail({super.key, required this.idPartido});

  @override
  State<game_detail> createState() => _game_detailState(idPartido: idPartido);
}

class _game_detailState extends State<game_detail> {
  String? selectedTeam;
  Promedio promedios = Promedio(data: []);
  final int idPartido;
  _game_detailState({required this.idPartido});
  @override
  void initState() {
    super.initState();
    _loadGameDetails();
  }

  // Función para cargar las estadisticas de los jugadores
  void _loadGameDetails() async {
    Promedio promedioTemporal = Promedio(data: []);
    promedioTemporal = await ApiService.getStatsByGame(idPartido);
    setState(() {
      promedios = promedioTemporal;
      if (promedios.data.isNotEmpty) {
        final homeTeam = promedios.data[0].game.homeTeam;
        final visitorTeam = promedios.data[0].game.visitorTeam;

        // Verificar que homeTeam y visitorTeam no sean nulos
        selectedTeam = homeTeam?.fullName ?? (visitorTeam?.fullName ?? 'Unknown Home Team');
      }
    });
    
    
  }

  @override
  Widget build(BuildContext context) {
    final homeTeamName = promedios.data.isNotEmpty ? promedios.data[0].game.homeTeam?.fullName ?? 'Unknown Home Team' : 'Loading Home Team...';
    final visitorTeamName = promedios.data.isNotEmpty ? promedios.data[0].game.visitorTeam?.fullName ?? 'Unknown Visitor Team' : 'Loading Visitor Team...';
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 25.0)),
                  Text("Choose Team: "),
                  DropdownButton<String>(
                    value: selectedTeam,
                    onChanged: (value) {
                      setState(() {
                        selectedTeam = value!;
                        _loadGameDetails();
                      });
                    },
                    
                     items: promedios.data.isNotEmpty
                        ? <String>[homeTeamName, visitorTeamName].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList()
                        : [],
                  ),
                ],
              ),
              DataTable(
                  columnSpacing: 15.5,
                  columns: const [
                    DataColumn(label: Text("Jugadores")),
                    DataColumn(label: Text("MIN")),
                    DataColumn(label: Text("PTS")),
                    DataColumn(label: Text("REB")),
                    DataColumn(label: Text("AST")),
                    DataColumn(label: Text("STL")),
                    DataColumn(label: Text("BLK")),
                    DataColumn(label: Text("FGM")),
                    DataColumn(label: Text("FGA")),
                    DataColumn(label: Text("FG%")),
                    DataColumn(label: Text("3PM")),
                    DataColumn(label: Text("3PA")),
                    DataColumn(label: Text("3P%")),
                    DataColumn(label: Text("FTM")),
                    DataColumn(label: Text("FTA")),
                    DataColumn(label: Text("FT%")),
                    DataColumn(label: Text("OREB")),
                    DataColumn(label: Text("DREB")),
                    DataColumn(label: Text("TO")),
                    DataColumn(label: Text("PF")),
                  ],
                  rows: promedios.data
                      .map((promedio) => DataRow(cells: [
                            DataCell(Text(
                                "${promedio.player.nombreJugador} ${promedio.player.apellidoJugador} ${promedio.player.posicionJugador}")),
                            DataCell(Text(promedio.min.toString())),
                            DataCell(Text(promedio.pts.toString())),
                            DataCell(Text(promedio.reb.toString())),
                            DataCell(Text(promedio.ast.toString())),
                            DataCell(Text(promedio.stl.toString())),
                            DataCell(Text(promedio.blk.toString())),
                            DataCell(Text(promedio.fgm.toString())),
                            DataCell(Text(promedio.fga.toString())),
                            DataCell(Text(promedio.fgPct.toString())),
                            DataCell(Text(promedio.fg3M.toString())),
                            DataCell(Text(promedio.fg3A.toString())),
                            DataCell(Text(promedio.fg3Pct.toString())),
                            DataCell(Text(promedio.ftm.toString())),
                            DataCell(Text(promedio.fta.toString())),
                            DataCell(Text(promedio.ftPct.toString())),
                            DataCell(Text(promedio.oreb.toString())),
                            DataCell(Text(promedio.dreb.toString())),
                            DataCell(Text(promedio.turnover.toString())),
                            DataCell(Text(promedio.pf.toString())),
                          ]))
                      .toList()),
            ],
          ),
        ),
      ),
    );
  }
}
