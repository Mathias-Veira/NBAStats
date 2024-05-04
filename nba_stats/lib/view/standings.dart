import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

    // Verifica si el resultado no es nulo
    if (ranking != null) {
      // Actualiza el estado con el resultado
      setState(() {
        equipos = ranking;
      });
    } else {
      // Maneja el caso en el que no se pueda obtener el ranking
      // Puedes mostrar un mensaje de error o realizar otras acciones según sea necesario
    }
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DataTable(
        columns: [
          DataColumn(label: Text("Name"))
        ], 
        rows: equipos.map((equipo) => DataRow(cells:[
          DataCell(Text(equipo.nombreEquipo)),
        ])).toList()),
    );
  }
}