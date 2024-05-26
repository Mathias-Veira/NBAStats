import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nba_stats/controller/api_request.dart';
import 'package:nba_stats/model/equipo.dart';

class standings extends StatefulWidget {
  const standings({super.key});

  @override
  State<standings> createState() => _standingsState();
}

class _standingsState extends State<standings> {
  String selectedConference = "None";
  String selectedDivision = "None";
  List<Equipo> equipos = [];

  @override
  void initState() {
    super.initState();
    _loadRanking();
  }

  // Función para cargar el ranking
  void _loadRanking() async {
    List<Equipo>? ranking = [];
    if (selectedConference == "None" && selectedDivision == "None") {
      ranking = await ApiService.getRanking();
    } else if (selectedConference != 'None') {
      ranking = await ApiService.getRankingByConference(selectedConference);
    } else if (selectedDivision != 'None') {
      ranking = await ApiService.getRankingByDivision(selectedDivision);
    }

    setState(() {
      equipos = ranking!;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> listIDs = List<String>.generate(31, (counter) => "$counter");
    int i = 1;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(padding: EdgeInsets.only(left: 25.0)),
                Text("Filtrar Por Conferencia: "),
                DropdownButton<String>(
                  value: selectedConference,
                  onChanged: (value) {
                    setState(() {
                      selectedConference = value!;
                      _loadRanking();
                    });
                  },
                  items: <String>['None', 'East', 'West']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Padding(padding: EdgeInsets.only(left: 25.0)),
                Text("Filtrar Por División: "),
                DropdownButton<String>(
                  value: selectedDivision,
                  onChanged: (value) {
                    setState(() {
                      selectedDivision = value!;
                      _loadRanking();
                    });
                  },
                  items: <String>[
                    'None',
                    'Atlantic',
                    'Central',
                    'Southeast',
                    'Northwest',
                    'Pacific',
                    'SouthWest'
                  ].map<DropdownMenuItem<String>>((String value) {
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
                  DataColumn(label: Text("")),
                  DataColumn(label: Text("Nombre")),
                  DataColumn(label: Text("Victorias")),
                  DataColumn(label: Text("Derrotas")),
                  DataColumn(label: Text("Porcentaje Victorias")),
                  DataColumn(label: Text("Conferencia")),
                  DataColumn(label: Text("División")),
                ],
                rows: equipos
                    .map((equipo) => DataRow(cells: [
                          DataCell(Text(listIDs[i++])),
                          DataCell(
                            Container(
                              width: 40,
                              decoration:
                                  const BoxDecoration(shape: BoxShape.circle),
                              child: Image.asset(
                                  'assets/img_teams/${equipo.ciudadEquipo} ${equipo.nombreEquipo}.png'),
                            ),
                          ),
                          DataCell(Text(equipo.abreviacionEquipo)),
                          DataCell(Text(equipo.nVictorias.toString())),
                          DataCell(Text(equipo.nDerrotas.toString())),
                          DataCell(Text(equipo.porcentajeVictorias.toString())),
                          DataCell(Text(equipo.conferenciaEquipo)),
                          DataCell(Text(equipo.divisionEquipo)),
                        ]))
                    .toList()),
          ],
        ),
      ),
    );
  }
}
