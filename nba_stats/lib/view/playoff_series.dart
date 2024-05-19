import 'package:flutter/material.dart';
import 'package:nba_stats/controller/api_request.dart';

import '../model/game.dart';

class playoff_series extends StatefulWidget {
  const playoff_series({super.key});

  @override
  State<playoff_series> createState() => _playoff_seriesState();
}

class _playoff_seriesState extends State<playoff_series> {
  Game partidos = Game(data: []);
  Game partidosVerificados = Game(data: []);
  int i = 0;
  @override
  void initState() {
    super.initState();
    _listarPartidosPlayOffs();
  }

  void _listarPartidosPlayOffs() async {
    Game partidosTemporales = Game(data: []);
    partidosTemporales = await ApiService.getPlayOffGames();
    setState(() {
      partidos = partidosTemporales;
    });
  }

  void executeAfterBuild() {
    partidosVerificados.data.add(partidos.data[i]);
  }

  @override
  Widget build(BuildContext context) {
    List<int> res = [];
    return ListView.builder(
        itemCount: partidos.data.length,
        itemBuilder: (context, index) {
          i = index;
          //partidos es el objeto Game con todos los partidos de la postemporada
          //index es el índice del partido que se va a mostrar
          res = calcularResultadoSerie(index, partidos);
          if (partidosVerificados.data.contains(partidos.data[index])) {
            return const SizedBox.shrink();
          }

          Widget carta = Card(
            child: ListTile(
              title: Row(
                children: [
                  Image.asset(
                    'assets/img_teams/' +
                        partidos.data[index].homeTeam!.city +
                        ' ' +
                        partidos.data[index].homeTeam!.name +
                        '.png',
                    width: 30.0,
                    height: 30.0,
                  ),
                  Padding(padding: EdgeInsets.only(left: 15.0)),
                  Text("${partidos.data[index].homeTeam!.name} ${res[0]} "),
                  const Text(' - '),
                  Text('${res[1]} ${partidos.data[index].visitorTeam!.name}'),
                  Padding(padding: EdgeInsets.only(left: 15.0)),
                  Image.asset(
                    'assets/img_teams/' +
                        partidos.data[index].visitorTeam!.city +
                        ' ' +
                        partidos.data[index].visitorTeam!.name +
                        '.png',
                    width: 30.0,
                    height: 30.0,
                  ),
                ],
              ),
            ),
          );
          executeAfterBuild();
          return carta;
        });
  }
}

// Este método calcula los resultados de las series de playOffs recorriendo la lista de partidos de la postemporada sacados de una API.
List<int> calcularResultadoSerie(int index, Game game) {
  //lista en la que se guarda el resultado de la serie
  List<int> res = [];
  //Numero de victorias del equipo local
  int contadorHomeTeam = 0;
  //numero de victorias del equipo visitante
  int contadorVisitorTeam = 0;
  //recorremos la lista de partidos
  for (var i = 0; i < game.data.length; i++) {
    // Primero comprobamos que el nombre del equipo local y visitante sean el mismo que el nombre del equipo local y visitante en el índice index (el partido que se está mostrando en la interfaz).
    //También se comprueba que los nombres se hayan intercambiado, es decir, que el equipo local pase a ser el equipo visitante y viceversa
    if (game.data[i].homeTeam!.name == game.data[index].homeTeam!.name &&
            game.data[i].visitorTeam!.name ==
                game.data[index].visitorTeam!.name ||
        (game.data[i].homeTeam!.name == game.data[index].visitorTeam!.name &&
            game.data[i].visitorTeam!.name ==
                game.data[index].homeTeam!.name)) {
      //Como las series de los playoffs son al mejor de 7 (el que gane 4 partidos gana la serie) se comprueba si uno de los contadores llegó a 4
      // de ser así, se sale del bucle
      if (contadorHomeTeam == 4 || contadorVisitorTeam == 4) {
        break;
      }
      //Comprobamos el resultado del partido
      //Se comprueba si el ganador fue el equipo local
      if (game.data[i].homeTeamScore > game.data[i].visitorTeamScore) {
        //De ser así, se comprueba si los nombres se intercambiaron, es decir, si el equipo local pasó a ser visitante y viceversa.
        if (game.data[i].homeTeam!.name == game.data[index].visitorTeam!.name &&
            game.data[i].visitorTeam!.name == game.data[index].homeTeam!.name) {
          //Si los nombres se cambiaron se aumenta el contador del equipo visitante
          contadorVisitorTeam++;
        } else {
          //Si no se cambiaron, se aumenta el contador del equipo local
          contadorHomeTeam++;
        }
        //Se comprueba si el ganador fue el equipo visitante
      } else if (game.data[i].visitorTeamScore > game.data[i].homeTeamScore) {
        //Se comprueba si los nombres se intercambiaron
        if (game.data[i].homeTeam!.name == game.data[index].visitorTeam!.name &&
            game.data[i].visitorTeam!.name == game.data[index].homeTeam!.name) {
          //Si se cambiaron se aumenta el contador del equipo local
          contadorHomeTeam++;
        } else {
          //Si no se cambiaron se aumenta el contador del equipo visitante
          contadorVisitorTeam++;
        }
      }
    }
  }
  //Se añaden los resultados a la lista y se devuelve
  res.add(contadorHomeTeam);
  res.add(contadorVisitorTeam);
  return res;
}
