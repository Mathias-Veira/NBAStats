import 'package:flutter/material.dart';
import 'package:nba_stats/model/promedio_jugadores.dart';

import '../controller/api_request.dart';

class stats_leaders extends StatefulWidget {
  const stats_leaders({super.key});

  @override
  State<stats_leaders> createState() => _stats_leadersState();
}

class _stats_leadersState extends State<stats_leaders> {
  String selectedStat = "None";
  List<PromedioJugadores> promedios = [];
  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  // Función para cargar el ranking
  void _loadStats() async {
    List<PromedioJugadores>? promedioTemporal = [];
    promedioTemporal = await ApiService.getPromedioByStat(selectedStat);
    setState(() {
      promedios = promedioTemporal!;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> listIDs = List<String>.generate(11, (counter) => "$counter");
    int i = 1;
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
                  Text("Filter by Stat: "),
                  DropdownButton<String>(
                    value: selectedStat,
                    onChanged: (value) {
                      setState(() {
                        selectedStat = value!;
                        _loadStats();
                      });
                    },
                    items: <String>['None', 'Puntos', 'Asistencias', 'Rebotes', 'Pérdidas', 'Robos', 'Tapones']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              DataTable(
                  columnSpacing: 15.5,
                  columns: [
                    DataColumn(label: Text("Ranking")),
                    DataColumn(label: Text("Jugadores")),
                    DataColumn(label: Text("Puntos")),
                    DataColumn(label: Text("Asistencias")),
                    DataColumn(label: Text("Rebotes")),
                    DataColumn(label: Text("Pérdidas")),
                    DataColumn(label: Text("Robos")),
                    DataColumn(label: Text("Tapones")),
                  ],
                  rows: promedios
                      .map((promedio) => DataRow(cells: [
                            DataCell(Text(listIDs[i++])),
                            DataCell(Text("${promedio.nombreJugador!} ${promedio.apellidoJugador}")),
                            DataCell(Text(promedio.puntosPorPartido.toString())),
                            DataCell(
                                Text(promedio.asistenciasPorPartido.toString())),
                            DataCell(Text(promedio.rebotesPorPartido.toString())),
                            DataCell(
                                Text(promedio.perdidasPorPartido.toString())),
                            DataCell(Text(promedio.robosPorPartido.toString())),
                            DataCell(Text(promedio.taponesPorPartido.toString())),
                          ]))
                      .toList()),
            ],
          ),
        ),
      ),
    );
  }
}
