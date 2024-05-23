import 'package:flutter/material.dart';
import 'package:nba_stats/controller/api_request.dart';
import 'package:nba_stats/model/equipo.dart';

import '../model/apoyar.dart';
import '../model/usuario.dart';

class NBAChampion extends StatefulWidget {
  final Usuario? user;
  const NBAChampion({super.key, required this.user});

  @override
  State<NBAChampion> createState() => _NBAChampionState(user: user);
}

class _NBAChampionState extends State<NBAChampion> {
  final Usuario? user;
  List<Equipo> equipos = [];
  _NBAChampionState({required this.user});
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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: equipos.length,
        itemBuilder: (_, index) {
          return Card(
            child: ListTile(
              onTap: () =>
                  apoyarEquipo(user!.usuarioId, equipos[index].idEquipo),
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
