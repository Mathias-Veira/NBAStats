import 'package:flutter/material.dart';
import 'package:nba_stats/controller/api_request.dart';
import 'package:nba_stats/model/equipo.dart';

import '../model/apoyar.dart';
import '../model/usuario.dart';

class NBAChampion extends StatefulWidget {
  final Usuario? user;
  const NBAChampion({super.key, required this.user});

  @override
  State<NBAChampion> createState() => _NBAChampionState();
}

class _NBAChampionState extends State<NBAChampion> {
  List<Equipo> equipos = [];

  @override
  void initState() {
    super.initState();
    getAllTeams();
  }

  void getAllTeams() async {
    List<Equipo> equiposTemporal = [];
    equiposTemporal = await ApiService.getAllTeams();
    equiposTemporal.sort;
    setState(() {
      equipos = equiposTemporal;
    });
  }

  apoyarEquipo(int idUsuario, int idEquipo) {
    ApiService.apoyarEquipo(Apoyar(idUsuario: idUsuario, idEquipo: idEquipo));
  }

  void showSnackBar(BuildContext context, String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        mensaje,
        textAlign: TextAlign.center,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: equipos.length,
        itemBuilder: (_, index) {
          return Card(
            child: ListTile(
              onTap: () {
                apoyarEquipo(widget.user!.usuarioId, equipos[index].idEquipo);
                showSnackBar(context, "Añadido a Equipos Favoritos");
              },
              title: Row(
                children: [
                  Image.asset(
                    equipos[index].imagenEquipo,
                    width: 30.0,
                    height: 30.0,
                  ),
                  Padding(padding: EdgeInsets.only(left: 20)),
                  Text(
                    '${equipos[index].ciudadEquipo} ${equipos[index].nombreEquipo}',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
