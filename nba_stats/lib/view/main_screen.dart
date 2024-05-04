import 'package:flutter/material.dart';
import 'package:nba_stats/view/standings.dart';

import 'games.dart';
import 'home.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _HomeState();
}

class _HomeState extends State<MainScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final screens = [const Home(), const Games(),const standings()];
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color: Theme.of(context).hintColor,),
            activeIcon: Icon(Icons.home_filled,color: Theme.of(context).hintColor,),
            label: 'Home',
            backgroundColor: Theme.of(context).hintColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_basketball,color: Theme.of(context).hintColor,),
            activeIcon: Icon(Icons.sports_basketball_outlined,color: Theme.of(context).hintColor,),
            label: 'Games',
            backgroundColor: Theme.of(context).hintColor,
            
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.star_border,color: Theme.of(context).hintColor,),
            activeIcon: Icon(Icons.star,color: Theme.of(context).hintColor,),
            label: 'Standings',
            backgroundColor: Theme.of(context).hintColor,
            
          ),
        ],
      ),
    );
  }
}
