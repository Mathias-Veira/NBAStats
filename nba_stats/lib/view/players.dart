import 'package:flutter/material.dart';

class Players extends StatefulWidget {
  const Players({super.key});

  @override
  State<Players> createState() => _PlayersState();
}

class _PlayersState extends State<Players> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text("Players Works!"),
        )
      ]
    );
  }
}