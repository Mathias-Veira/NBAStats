import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'view/home.dart';

void main() {
  runApp(nbaStats());
  // Se establece la pantalla del sistema de forma inmersiva
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
}

//Clase Principal

class nbaStats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NBA Stats',
      debugShowCheckedModeBanner: false,
      //establecemos la ruta principal
      initialRoute: '/home',
      routes: {
        '/home': (BuildContext context) => Home(),
      },
    );
  }
}
