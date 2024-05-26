import 'package:flutter/material.dart';
import 'package:nba_stats/controller/api_request.dart';
import 'package:nba_stats/model/equipo.dart';
import 'package:nba_stats/model/promedio_jugadores.dart';
import 'package:nba_stats/model/seguir.dart';
import 'package:nba_stats/model/usuario.dart';

import '../model/player.dart';

class SearchMVPDelegate extends SearchDelegate {
  final Usuario? usuario;
  SearchMVPDelegate({required this.players, required this.usuario});
  List<Jugador> players;
  List<Jugador> _filter = [];
  List<PromedioJugadores> promedios = [];
  List<Equipo> equipos = [];

  void getPlayers() async {
    players = await ApiService.listarJugadores();
  }

  void getStats() async {
    promedios = await ApiService.getStats();
  }

  void getAllTeams() async {
    equipos = await ApiService.getAllTeams();
  }

  String getTeamById(int teamId) {
    for (var equipo in equipos) {
      if (equipo.idEquipo == teamId) {
        return equipo.nombreEquipo;
      }
    }
    return '';
  }

  String getTeamImageById(int teamId) {
    for (var equipo in equipos) {
      if (equipo.idEquipo == teamId) {
        return equipo.imagenEquipo;
      }
    }
    return '';
  }

  double findStat(int jugadorId, String statName) {
    for (var i = 0; i < promedios.length; i++) {
      if (promedios[i].idJugador == jugadorId) {
        switch (statName) {
          case 'pts':
            return promedios[i].puntosPorPartido;
          case 'ast':
            return promedios[i].asistenciasPorPartido;
          case 'reb':
            return promedios[i].rebotesPorPartido;
          case 'tov':
            return promedios[i].perdidasPorPartido;
          case 'stl':
            return promedios[i].robosPorPartido;
          case 'blk':
            return promedios[i].taponesPorPartido;
          default:
            return 0.0;
        }
      }
    }
    return 0.0;
  }

  seguirJugador(int idUsuario, int idJugador) {
    ApiService.seguirJugador(
        Seguir(idUsuario: idUsuario, idJugador: idJugador));
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
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
        itemCount: _filter.length,
        itemBuilder: (_, index) {
          return Card(
            child: ListTile(
              onTap: () {
                seguirJugador(usuario!.usuarioId, _filter[index].idJugador);
                showSnackBar(context, "Añadido a jugadores Favoritos");
              },
              title: Row(
                children: [
                  Text(
                    '${_filter[index].nombreJugador} ${_filter[index].apellidoJugador}',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const Padding(padding: EdgeInsets.only(left: 20.0)),
                  Image.asset(
                    getTeamImageById(_filter[index].idEquipo),
                    width: 30.0,
                    height: 30.0,
                  ),
                  Text(" " + getTeamById(_filter[index].idEquipo),
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
              subtitle: Text(
                  "Puntos: ${findStat(_filter[index].idJugador, "pts")}\nAsistencias: ${findStat(_filter[index].idJugador, "ast")}\nRebotes: ${findStat(_filter[index].idJugador, "reb")}\nPérdidas: ${findStat(_filter[index].idJugador, "tov")}\nRobos: ${findStat(_filter[index].idJugador, "stl")}\nTapones: ${findStat(_filter[index].idJugador, "blk")}"),
            ),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    getPlayers();
    getStats();
    getAllTeams();
    _filter = players.where((element) {
      return element.nombreJugador
              .toLowerCase()
              .contains(query.trim().toLowerCase()) ||
          element.apellidoJugador
              .toLowerCase()
              .contains(query.trim().toLowerCase());
    }).toList();
    return ListView.builder(
        itemCount: _filter.length,
        itemBuilder: (_, index) {
          return Card(
            child: ListTile(
              onTap: () {
                seguirJugador(usuario!.usuarioId, _filter[index].idJugador);
                showSnackBar(context, "Añadido a Jugadores Favoritos");
              },
              title: Row(
                children: [
                  Text(
                    '${_filter[index].nombreJugador} ${_filter[index].apellidoJugador}',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const Padding(padding: EdgeInsets.only(left: 20.0)),
                  Image.asset(
                    getTeamImageById(_filter[index].idEquipo),
                    width: 30.0,
                    height: 30.0,
                  ),
                  Text(" " + getTeamById(_filter[index].idEquipo),
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
              subtitle: Text(
                  "Puntos: ${findStat(_filter[index].idJugador, "pts")}\nAsistencias: ${findStat(_filter[index].idJugador, "ast")}\nRebotes: ${findStat(_filter[index].idJugador, "reb")}\nPérdidas: ${findStat(_filter[index].idJugador, "tov")}\nRobos: ${findStat(_filter[index].idJugador, "stl")}\nTapones: ${findStat(_filter[index].idJugador, "blk")}"),
            ),
          );
        });
  }
}
