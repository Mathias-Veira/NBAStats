import 'package:flutter/material.dart';
import 'package:nba_stats/controller/api_request.dart';

import '../model/player.dart';

class SearchPlayerDelegate extends SearchDelegate {
  List<Jugador> players;
  List<Jugador> _filter = [];
  SearchPlayerDelegate(this.players);

  void getPlayers() async {
    players = await ApiService.listarJugadores();
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
            ),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    getPlayers();
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
                  _filter[index].apellidoJugador + " PTS: "),
            ),
          );
        });
  }
}
