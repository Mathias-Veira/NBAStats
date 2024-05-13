import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nba_stats/view/games_detail.dart';


import 'view/main_screen.dart';

void main()  {
  runApp(NbaStats());
  // Se establece la pantalla del sistema de forma inmersiva
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
}

//Clase Principal

class NbaStats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      title: 'NBA Stats',
      debugShowCheckedModeBanner: false,
      //establecemos la ruta principal
      initialRoute: '/home',
      routes: {
        '/home': (BuildContext context) => const MainScreen(),
        '/game_detail': (BuildContext context) => const game_detail(idPartido: 0,),
      },
    );
  }
}
