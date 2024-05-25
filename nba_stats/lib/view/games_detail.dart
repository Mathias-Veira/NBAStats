import 'dart:math';

import 'package:flutter/material.dart';

import '../controller/api_request.dart';
import '../model/estadistica.dart';

class game_detail extends StatefulWidget {
  final int idPartido;
  const game_detail({super.key, required this.idPartido});

  @override
  State<game_detail> createState() => _game_detailState();
}

class _game_detailState extends State<game_detail> {
  Estadistica promedios = Estadistica(data: []);
 
  @override
  void initState() {
    super.initState();
    _loadGameDetails();
  }

  // Función para cargar las estadisticas de los jugadores
  void _loadGameDetails() async {
    Estadistica promedioTemporal = Estadistica(data: []);
    promedioTemporal = await ApiService.getStatsByGame(widget.idPartido);
    promedioTemporal = ordenarPromedios(promedioTemporal);
    setState(() {
      promedios = promedioTemporal;
    });
  }

  Estadistica ordenarPromedios(Estadistica promedioTemporal) {
    Estadistica promedioOrdenado = Estadistica(data: []);
    promedioTemporal.data.sort((promedioA, promedioB) {
      int teamComparison = promedioA.team.name.compareTo(promedioB.team.name);
      if (teamComparison != 0) {
        return teamComparison;
      } else {
        return -promedioA.min!.compareTo(promedioB.min!);
      }
    });

    promedioOrdenado = promedioTemporal;
    return promedioOrdenado;
  }

  double truncateToDecimalPlaces(num value, int fractionalDigits) =>
      (value * pow(10, fractionalDigits)).truncate() /
      pow(10, fractionalDigits);

  @override
  Widget build(BuildContext context) {
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
                ],
              ),
              DataTable(
                  columnSpacing: 15.5,
                  columns: const [
                    DataColumn(label: Text("Jugadores")),
                    DataColumn(label: Text("Equipo")),
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
                            DataCell(Text("${promedio.team.name}")),
                            DataCell(Text(promedio.min.toString())),
                            DataCell(Text(promedio.pts.toString())),
                            DataCell(Text(promedio.reb.toString())),
                            DataCell(Text(promedio.ast.toString())),
                            DataCell(Text(promedio.stl.toString())),
                            DataCell(Text(promedio.blk.toString())),
                            DataCell(Text(promedio.fgm.toString())),
                            DataCell(Text(promedio.fga.toString())),
                            DataCell(Text(
                                (truncateToDecimalPlaces(promedio.fgPct!, 1))
                                    .toString())),
                            DataCell(Text(promedio.fg3M.toString())),
                            DataCell(Text(promedio.fg3A.toString())),
                            DataCell(Text(
                                (truncateToDecimalPlaces(promedio.fg3Pct!, 1))
                                    .toString())),
                            DataCell(Text(promedio.ftm.toString())),
                            DataCell(Text(promedio.fta.toString())),
                            DataCell(Text(
                                (truncateToDecimalPlaces(promedio.ftPct!, 1))
                                    .toString())),
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
