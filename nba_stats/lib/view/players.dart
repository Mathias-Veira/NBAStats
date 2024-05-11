import 'package:flutter/material.dart';
import 'package:nba_stats/controller/search_player_delegate.dart';

import '../model/player.dart';

class Players extends StatefulWidget {
  const Players({super.key});

  @override
  State<Players> createState() => _PlayersState();
}

class _PlayersState extends State<Players> {
  List<Jugador> players = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: ListTile(
          trailing: Icon(Icons.search),
          onTap: () {
            showSearch(
                context: context, delegate: SearchPlayerDelegate(players));
          },
          title: const Text(
            'Search Players',
          ),
        ),
      ),
    );
  }
}
