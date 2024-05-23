import 'package:flutter/material.dart';

import '../controller/search_mvp_delegate.dart';
import '../model/player.dart';

class MVP extends StatefulWidget {
  const MVP({super.key});

  @override
  State<MVP> createState() => _MVPState();
}

class _MVPState extends State<MVP> {
  List<Jugador> players = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: ListTile(
          trailing: const Icon(Icons.search),
          onTap: () {
            showSearch(
                context: context, delegate: SearchMVPDelegate(players));
          },
          title: const Text(
            'Search Your MVP',
          ),
        ),
      ),
    );
  }
}