// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:nba_stats/model/apoyar.dart';
import 'package:nba_stats/model/equipo.dart';
import 'package:nba_stats/model/game.dart';
import 'package:nba_stats/model/promedio_jugadores.dart';

import '../model/acceso.dart';
import '../model/data.dart';
import '../model/player.dart';
import '../model/estadistica.dart';
import '../model/seguir.dart';
import '../model/usuario.dart';

//Clase que contiene los métodos necesarios para conectarse a la API
class ApiService {
  //URL base de la API
  static const String baseUrl = 'http://192.168.1.118:8080/api';

  //Este método permite crear un usuario
  static Future<int> crearUsuario(Usuario usuario) async {
    String url = '$baseUrl/usuarios';
    int statusCode = 0;
    //En esta variable se almacena el usuario que se pasa por parámetro convertido en json
    String jsonBody = json.encode(usuario.toJson());

    try {
      //Se realiza la petición post a la api
      http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonBody,
      );
      //Se guarda el código de respuesta
      statusCode = response.statusCode;
      //Se verifica si el código de respuesta es el 201 (created)
      if (statusCode == 201) {
        print('Usuario creado exitosamente.');
      } else {
        print('Error al crear usuario: $statusCode $jsonBody');
      }
    } catch (e) {
      print('Error de conexión: $e');
    }
    //Se devuelve el código de respuesta
    return statusCode;
  }

  static Future<Usuario> obtenerUsuario(String nombre) async {
    String url = '$baseUrl/usuarios/$nombre';
    int statusCode = 0;

    try {
      //Se realiza la petición post a la api
      http.Response response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      return usuarioFromJson(response.body);
    } catch (e) {
      print('Error de conexión: $e');
    }
    return Usuario(usuarioId: 0, nombreUsuario: '', passwordUsuario: '');
  }

  //Este método permite verificar si los datos de inicio de sesión son correctos
  static Future<int> iniciarSesion(Acceso acceso) async {
    String url = '$baseUrl/login';
    int statusCode = 0;
    //En esta variable se almacena el usuario que se pasa por parámetro convertido en json
    String jsonBody = json.encode(acceso.toJson());

    try {
      //Se realiza la petición post al endpoint
      http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonBody,
      );
      //Se almacena el código de respuesta
      statusCode = response.statusCode;
      //Se verifica que el código de respuesta sea 204 (no content)
      if (statusCode == 204) {
        print('Inicio de sesión exitoso.');
      } else {
        print('Error al iniciar sesión: $statusCode $jsonBody');
      }
    } catch (e) {
      print('Error de conexión: $e');
    }
    //Se devuelve código de respuesta
    return statusCode;
  }

  //Este método permite listar todos los mazos de un usuario en concreto
  static Future<List<Jugador>> listarJugadores() async {
    String url = '$baseUrl/players';
    List<Jugador> jugadores = [];
    try {
      //Se realiza la petición get al endpoint
      http.Response response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      return jugadorListFromJson(response.body);
    } catch (e) {
      print('Error conexión: $e');
    }
    //Se devuelve la lista de jugadores
    return jugadores;
  }

  static Future<Game?> listarPartidos(DateTime fecha) async {
    String url =
        'https://api.balldontlie.io/v1/games?dates[]=${fecha.year}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}';
    try {
      //Se realiza la petición get al endpoint
      http.Response response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': '475f2ca9-26a3-4a5b-a3d8-2942adc3f3ad',
        },
      );
      return gameFromJson(response.body);
    } catch (e) {
      print('Error conexión: $e');
    }
    //Se devuelve la lista de partidos
    return null;
  }

  static Future<List<Equipo>> getRanking() async {
    String url = '$baseUrl/ranking';
    try {
      //Se realiza la petición get al endpoint
      http.Response response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      return equipoFromJson(response.body);
    } catch (e) {
      print('Error conexión: $e');
    }
    //Se devuelve la lista de partidos
    return List.empty();
  }

  static Future<List<Equipo>> getRankingByConference(String conference) async {
    String url = '$baseUrl/ranking/$conference';
    try {
      //Se realiza la petición get al endpoint
      http.Response response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      return equipoFromJson(response.body);
    } catch (e) {
      print('Error conexión: $e');
    }
    //Se devuelve la lista de partidos
    return List.empty();
  }

  static Future<List<Equipo>> getRankingByDivision(String division) async {
    String url = '$baseUrl/ranking/division/$division';
    try {
      //Se realiza la petición get al endpoint
      http.Response response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      return equipoFromJson(response.body);
    } catch (e) {
      print('Error conexión: $e');
    }
    //Se devuelve la lista de rankings
    return List.empty();
  }

  static Future<Estadistica> getStatsByGame(int idPartido) async {
    String url = 'https://api.balldontlie.io/v1/stats?game_ids[]=$idPartido';
    try {
      //Se realiza la petición get al endpoint
      http.Response response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': '475f2ca9-26a3-4a5b-a3d8-2942adc3f3ad',
        },
      );
      return promedioFromJson(response.body);
    } catch (e) {
      print('Error conexión: $e');
    }
    //Se devuelve la lista de partidos
    return Estadistica(data: []);
  }

  static Future<List<PromedioJugadores>> getStats() async {
    String url = '$baseUrl/stats';
    List<PromedioJugadores> promedio = [];
    try {
      //Se realiza la petición get al endpoint
      http.Response response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      return promedioJugadoresFromJson(response.body);
    } catch (e) {
      print('Error conexión: $e');
    }
    //Se devuelve la lista de partidos
    return promedio;
  }

  static Future<List<PromedioJugadores>> getPromedioByStat(String stat) async {
    String url = '';
    switch (stat) {
      case 'Puntos':
        url = '$baseUrl/stats/pts';
        break;
      case 'Asistencias':
        url = '$baseUrl/stats/ast';
        break;
      case 'Rebotes':
        url = '$baseUrl/stats/reb';
        break;
      case 'Pérdidas':
        url = '$baseUrl/stats/tov';
        break;
      case 'Robos':
        url = '$baseUrl/stats/stl';
        break;
      case 'Tapones':
        url = '$baseUrl/stats/blk';
        break;
      default:
        print('Opción no reconocida');
    }
    List<PromedioJugadores> promedio = [];
    if (stat == "None") {
      return promedio;
    }
    try {
      //Se realiza la petición get al endpoint
      http.Response response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      return promedioJugadoresFromJsonStats(response.body);
    } catch (e) {
      print('Error conexión: $e');
    }
    //Se devuelve la lista de partidos
    return promedio;
  }

  static Future<Game> getPlayOffGames() async {
    String url =
        'https://api.balldontlie.io/v1/games?postseason=true&seasons[]=2023&per_page=100';
    try {
      //Se realiza la petición get al endpoint
      http.Response response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': '475f2ca9-26a3-4a5b-a3d8-2942adc3f3ad',
        },
      );
      return gameFromJson(response.body);
    } catch (e) {
      print('Error conexión: $e');
    }
    return Game(data: []);
  }

  static Future<List<Equipo>> getAllTeams() async {
    String url = '$baseUrl/teams';
    List<Equipo> equipos = [];
    try {
      //Se realiza la petición get al endpoint
      http.Response response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      return equipoFromJson(response.body);
    } catch (e) {
      print('Error conexión: $e');
    }
    //Se devuelve la lista de partidos
    return equipos;
  }


  //Este método permite verificar si los datos de inicio de sesión son correctos
  static Future<int> seguirJugador(Seguir seguir) async {
    String url = '$baseUrl/seguir';
    int statusCode = 0;
    //En esta variable se almacena el usuario que se pasa por parámetro convertido en json
    String jsonBody = json.encode(seguir.toJson());

    try {
      //Se realiza la petición post al endpoint
      http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonBody,
      );
      //Se almacena el código de respuesta
      statusCode = response.statusCode;
      //Se verifica que el código de respuesta sea 200 (Ok)
      if (statusCode == 200) {
        print('Seguir a jugador exitoso.');
      } else {
        print('Error al seguir Jugador: $statusCode $jsonBody');
      }
    } catch (e) {
      print('Error de conexión: $e');
    }
    //Se devuelve código de respuesta
    return statusCode;
  }

  //Este método permite verificar si los datos de inicio de sesión son correctos
  static Future<int> apoyarEquipo (Apoyar apoyar) async {
    String url = '$baseUrl/apoyar';
    int statusCode = 0;
    //En esta variable se almacena el usuario que se pasa por parámetro convertido en json
    String jsonBody = json.encode(apoyar.toJson());

    try {
      //Se realiza la petición post al endpoint
      http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonBody,
      );
      //Se almacena el código de respuesta
      statusCode = response.statusCode;
      //Se verifica que el código de respuesta sea 200 (Ok)
      if (statusCode == 200) {
        print('Apoyar Equipo exitoso.');
      } else {
        print('Error al Apoyar Equipo : $statusCode $jsonBody');
      }
    } catch (e) {
      print('Error de conexión: $e');
    }
    //Se devuelve código de respuesta
    return statusCode;
  }

   //Este método permite listar todos los mazos de un usuario en concreto
  static Future<List<PromedioJugadores>> getAllFollowedPlayersStats(int idUsuario) async {
    String url = '$baseUrl/promedios/jugadores/seguidos/$idUsuario';
    List<PromedioJugadores> promedios = [];
    try {
      //Se realiza la petición get al endpoint
      http.Response response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      return promedioJugadoresFromJsonStats(response.body);
    } catch (e) {
      print('Error conexión: $e');
    }
    //Se devuelve la lista de jugadores
    return promedios;
  }

   //Este método permite listar todos los mazos de un usuario en concreto
  static Future<Equipo> getTeamById(int idJugador) async {
    String url = '$baseUrl/team/$idJugador';
    Equipo equipo = Equipo(idEquipo: 0, nombreEquipo: "", ciudadEquipo: "", abreviacionEquipo: "", imagenEquipo: "", conferenciaEquipo: "", divisionEquipo: "", puestoConferencia: 0, puestoDivision: 0, nVictorias: 0, nDerrotas: 0, porcentajeVictorias: 0);
    try {
      //Se realiza la petición get al endpoint
      http.Response response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      return unEquipoFromJson(response.body);
    } catch (e) {
      print('Error conexión: $e');
    }
    //Se devuelve la lista de jugadores
    return equipo ;
  }

   static Future<List<Equipo>> getAllFollowedTeams(int idUsuario) async {
    String url = '$baseUrl/equipos/apoyados/$idUsuario';
    List<Equipo> equipos = [];
    try {
      //Se realiza la petición get al endpoint
      http.Response response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      return equipoFromJson(response.body);
    } catch (e) {
      print('Error conexión: $e');
    }
    //Se devuelve la lista de jugadores
    return equipos;
  }
}
