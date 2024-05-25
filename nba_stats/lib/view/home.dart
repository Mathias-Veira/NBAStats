import 'package:flutter/cupertino.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text(
            'Jugadores Favoritos',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          Container(
            height: 400,
            child: FutureBuilder(
                future:
                    ApiService.getAllFollowedPlayersStats(user?.usuarioId ?? 0),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    return _ListarJugadoresFavoritos(
                        snapshot.data != null ? snapshot.data : [], equipos);
                  }
                }),
          ),
          const Text(
            'Equipos Favoritos',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _ListarJugadoresFavoritos extends StatelessWidget {
  List<PromedioJugadores> promedios;
  List<Equipo> equipos;
  _ListarJugadoresFavoritos(this.promedios, this.equipos);

  Future<List<Equipo>> fetchTeams() async {
    List<Equipo> equipos = [];
    for (var promedio in promedios) {
      equipos.add(await ApiService.getTeamById(promedio.idJugador));
    }
    return equipos;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchTeams(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            equipos = snapshot.data;
            return ListView.builder(
                itemCount: promedios.length,
                itemBuilder: (_, index) {
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
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      subtitle: Text(
                          "Puntos: ${promedios[index].puntosPorPartido}\nAsistencias: ${promedios[index].asistenciasPorPartido}\nRebotes: ${promedios[index].rebotesPorPartido}\nPérdidas: ${promedios[index].perdidasPorPartido}\nRobos: ${promedios[index].puntosPorPartido}\nTapones: ${promedios[index].taponesPorPartido}"),
                    ),
                  );
                });
          }
        });
  }
}
