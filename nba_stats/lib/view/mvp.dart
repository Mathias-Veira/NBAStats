import 'package:flutter/material.dart';
import 'package:nba_stats/model/usuario.dart';

import '../controller/search_mvp_delegate.dart';
import '../model/player.dart';

class MVP extends StatefulWidget {
  final Usuario? user;
  const MVP({super.key, required this.user});

  @override
  State<MVP> createState() => _MVPState(user: user);
}

class _MVPState extends State<MVP> {
  List<Jugador> players = [];
  final Usuario? user;
  _MVPState({required this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: ListTile(
          trailing: const Icon(Icons.search),
          onTap: () {
            showSearch(
                context: context,
                delegate: SearchMVPDelegate(
                    players: [],
                    usuario: user));
          },
          title: const Text(
            'Search Your MVP',
          ),
        ),
      ),
    );
  }
}
