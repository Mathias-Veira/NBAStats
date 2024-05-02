// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:nba_stats/model/game.dart';

import '../model/acceso.dart';
import '../model/data.dart';
import '../model/player.dart';
import '../model/usuario.dart';

//Clase que contiene los métodos necesarios para conectarse a la API
class ApiService {
  //URL base de la API
  static const String baseUrl = 'http://localhost:8080/api';

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

  //Este método permite verificar si los datos de inicio de sesión son correctos
  static Future<int> iniciarSesion(Acceso acceso) async {
    String url = '$baseUrl/iniciar-sesion';
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
    int statusCode = 0;
    List<Jugador> jugadores = [];
    try {
      //Se realiza la petición get al endpoint
      http.Response response = await http.get(Uri.parse(url));
      List<dynamic> jsonData = json.decode(response.body);
      jugadores = jsonData.map((item) => Jugador.fromJson(item)).toList();
      statusCode = response.statusCode;
      //Se verifica si el código de respuesta es un 200
      if (statusCode == 200) {
        print('listar mazos OK');
      } else {
        print('Error al listar mazos: $statusCode');
      }
    } catch (e) {
      print('Error conexión: $e');
    }
    //Se devuelve la lista de mazos
    return jugadores;
  }
  /*
  //Este método permite listar los partidos que se juegan en una fecha concreta
  static Future<List<Data>> listarPartidos(DateTime fecha) async {
    String url =
        'https://api.balldontlie.io/v1/games?dates[]=${fecha.year}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}';
    int statusCode = 0;
    List<Data> datos = [];
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

      Map<String, dynamic> jsonData = json.decode(response.body);
      Game game = Game.fromJson(jsonData);
      List<Data> datos = game.data;
      statusCode = response.statusCode;
      //Se verifica si el código de respuesta es un 200
      if (statusCode == 200) {
        print('listar partidos OK');
      } else {
        print('Error al listar partidos: $statusCode');
      }
    } catch (e) {
      print('Error conexión: $e');
    }
    //Se devuelve la lista de partidos
    return datos;
  }
  */

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


}
