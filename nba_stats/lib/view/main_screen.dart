import 'package:flutter/material.dart';
import 'package:nba_stats/view/standings.dart';

import 'games.dart';
import 'home.dart';
import 'players.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _HomeState();
}

class _HomeState extends State<MainScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final screens = [
      const Home(),
      const Games(),
      const standings(),
      const Players(),
    ];
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            activeIcon: Icon(
              Icons.home_filled,
              color: Colors.white,
            ),
            label: 'Home',
            backgroundColor: Colors.grey[850],
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.sports_basketball,
              color: Colors.white,
            ),
            activeIcon: Icon(
              Icons.sports_basketball_outlined,
              color: Colors.white,
            ),
            label: 'Games',
            backgroundColor: Colors.grey[850],
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star_border,
              color: Colors.white,
            ),
            activeIcon: Icon(
              Icons.star,
              color: Colors.white,
            ),
            label: 'Standings',
            backgroundColor: Colors.grey[850],
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.group_outlined,
              color: Colors.white,
            ),
            activeIcon: Icon(
              Icons.group,
              color: Colors.white,
            ),
            label: 'Players',
            backgroundColor: Colors.grey[850],
          ),
        ],
      ),
    );
  }
}
