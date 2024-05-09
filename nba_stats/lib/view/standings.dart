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
  List<Equipo> equipos = [];

  @override
  void initState() {
    super.initState();
    _loadRanking(); // Llama a una función para cargar el ranking
  }

  // Función para cargar el ranking
  void _loadRanking() async {
    // Espera a que se complete el Future y obtén el resultado
    List<Equipo>? ranking = await ApiService.getRanking();

    // Actualiza el estado con el resultado
    setState(() {
      equipos = ranking;
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
        child: DataTable(
          columnSpacing: 15.5,
            columns: [
              DataColumn(label: Text("Ranking")),
              DataColumn(label: Text("")),
              DataColumn(label: Text("Name")),
              DataColumn(label: Text("W")),
              DataColumn(label: Text("L")),
              DataColumn(label: Text("PCT")),
              DataColumn(label: Text("Conference")),
              DataColumn(label: Text("Division")),
            ],
            rows: equipos
                .map((equipo) => DataRow(cells: [
                      DataCell(Text(listIDs[i++])),
                      DataCell(
                        Container(
                            width: 40,
                            decoration: const BoxDecoration(shape: BoxShape.circle),
                            child: Image.asset('assets/img_teams/${equipo.ciudadEquipo} ${equipo.nombreEquipo}.png'),
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
      ),
    );
  }
}



