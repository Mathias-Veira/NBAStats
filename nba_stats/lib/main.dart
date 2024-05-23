import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nba_stats/view/games_detail.dart';
import 'package:nba_stats/view/mvp.dart';
import 'package:nba_stats/view/nba_champion.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'view/login.dart';
import 'view/main_screen.dart';
import 'view/playoff_series.dart';
import 'view/registro.dart';
import 'view/stats_leaders.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isLogedIn = await obtenerIsLogedIn();
  final userName = await obtenerUserName();
  runApp(NbaStats(isLogedIn: isLogedIn, userName: userName,));
  // Se establece la pantalla del sistema de forma inmersiva
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
}

Future<bool> obtenerIsLogedIn() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLogedIn') ?? false;
}

Future<String> obtenerUserName() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('userName') ?? '';
}

//Clase Principal

class NbaStats extends StatelessWidget {
  final bool isLogedIn;
  final String userName;
  const NbaStats({super.key, required this.isLogedIn,required this.userName});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      title: 'NBA Stats',
      debugShowCheckedModeBanner: false,
      //establecemos la ruta principal
      initialRoute: isLogedIn ? '/home' : '/login',
      routes: {
        '/home': (BuildContext context) =>
             MainScreen(nombreUsuario: userName),
        '/game_detail': (BuildContext context) => const game_detail(
              idPartido: 0,
            ),
        '/statsLeaders': (BuildContext context) => const stats_leaders(),
        '/playoffsSeries': (BuildContext context) => const playoff_series(),
        '/login': (BuildContext context) => LoginState(),
        '/registro': (BuildContext context) => RegistroState(),
        '/mvp':(BuildContext context) => const MVP(user: null,),
        '/champion':(BuildContext context) => const NBAChampion(),
      },
    );
  }
}
