import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nba_stats/model/equipo.dart';
import 'package:nba_stats/model/player.dart';
import 'package:nba_stats/model/promedio_jugadores.dart';

import '../controller/api_request.dart';
import '../model/usuario.dart';

class Home extends StatefulWidget {
  final Usuario? user;
  const Home({super.key, required this.user});

  @override
  State<Home> createState() => _HomeState(user: user);
}

class _HomeState extends State<Home> {
  List<Equipo> equipos = [];
  List<PromedioJugadores> promedios = [];
  final Usuario? user;
  _HomeState({required this.user});
  @override
  void initState() {
    super.initState();
    if (user != null) {
      getAllFollowedPlayersStats(user!.usuarioId);
      
    }
  }

  void getAllFollowedPlayersStats(int idUsuario) async {
    List<PromedioJugadores> promediosTemporales = [];
    promediosTemporales =
        await ApiService.getAllFollowedPlayersStats(idUsuario);
    setState(() {
      promedios = promediosTemporales;
    });
  }

  void getTeamById(int idJugador) async {
    equipos.add(await ApiService.getTeamById(idJugador));
  }

  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: [
        const Text(
          'Jugadores Favoritos',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
              itemCount: promedios.length,
              itemBuilder: (_, index) {
                getTeamById(promedios[index].idJugador);
                return Card(
                  child: ListTile(
                    title: Row(
                      children: [
                        Image.asset(
                          equipos[index].imagenEquipo,
                          width: 30.0,
                          height: 30.0,
                        ),
                        Text(
                          '${promedios[index].nombreJugador} ${promedios[index].apellidoJugador}',
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    subtitle: Text(
                        "Puntos: ${promedios[index].puntosPorPartido}\nAsistencias: ${promedios[index].asistenciasPorPartido}\nRebotes: ${promedios[index].rebotesPorPartido}\nPérdidas: ${promedios[index].perdidasPorPartido}\nRobos: ${promedios[index].puntosPorPartido}\nTapones: ${promedios[index].taponesPorPartido}"),
                  ),
                );
              }),
        ),
        const Text(
          'Equipos Favoritos',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ],
    );
  }
}
