import 'package:flutter/material.dart';
import 'package:nba_stats/controller/api_request.dart';
import 'package:nba_stats/model/promedio_jugadores.dart';

import '../model/player.dart';

class SearchPlayerDelegate extends SearchDelegate {
  List<Jugador> players;
  List<Jugador> _filter = [];
  SearchPlayerDelegate(this.players);
  List<PromedioJugadores> promedios = [];

  void getPlayers() async {
    players = await ApiService.listarJugadores();
  }

  void getStats() async {
    promedios = await ApiService.getStats();
  }

  double findStat(int jugadorId, String statName){
    for (var i = 0; i < promedios.length; i++) {
      if(promedios[i].idJugador == jugadorId){
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
                print('Opción no reconocida');
          }
          
      }
    }
    return 0.0;
  }


  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
        itemCount: _filter.length,
        itemBuilder: (_, index) {
          return Card(
            child: ListTile(
              title: Text(_filter[index].nombreJugador +
                  ' ' +
                  _filter[index].apellidoJugador),

              subtitle: Text("Puntos: " + findStat(_filter[index].idJugador, "pts").toString() + "\n" + "Asistencias: " + findStat(_filter[index].idJugador, "ast").toString() +"\n" + "Rebotes: " + findStat(_filter[index].idJugador, "reb").toString() + "\n" +"Pérdidas: " + findStat(_filter[index].idJugador, "tov").toString() + "\n" +"Robos: " + findStat(_filter[index].idJugador, "stl").toString() + "\n" +"Tapones: " + findStat(_filter[index].idJugador, "blk").toString()),
            ),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    getPlayers();
    getStats();
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
              title: Text(_filter[index].nombreJugador +
                  ' ' +
                  _filter[index].apellidoJugador, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),

              subtitle: Text("Puntos: " + findStat(_filter[index].idJugador, "pts").toString() + "\n" + "Asistencias: " + findStat(_filter[index].idJugador, "ast").toString() +"\n" + "Rebotes: " + findStat(_filter[index].idJugador, "reb").toString() + "\n" +"Pérdidas: " + findStat(_filter[index].idJugador, "tov").toString() + "\n" +"Robos: " + findStat(_filter[index].idJugador, "stl").toString() + "\n" +"Tapones: " + findStat(_filter[index].idJugador, "blk").toString()),
            ),
          );
        });
  }
}
