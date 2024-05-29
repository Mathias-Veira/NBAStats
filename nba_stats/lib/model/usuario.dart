import 'dart:convert';

//Este método convierte un json en objeto de la clase Usuario
Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));
//Este método convierte un objeto de la clase Usuario a json
String usuarioToJson(Usuario data) => json.encode(data.toJson());

//Clase usuario
class Usuario {
  //Atributos
  int usuarioId;
  String nombreUsuario;
  String passwordUsuario;
  //Constructor
  Usuario({
    required this.usuarioId,
    required this.nombreUsuario,
    required this.passwordUsuario,
  });
  //Este método permite construir un objeto de la clase Usuario haciendo uso del json
  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        usuarioId: json["idUsuario"]?? 0,
        nombreUsuario: json["nombreUsuario"]??'',
        passwordUsuario: json["passwordUsuario"]?? '',
      );
  //Este método convierte un objeto de la clase Usuario a un mapa el cuál se convertirá en un json
  Map<String, dynamic> toJson() => {
        "usuarioID": usuarioId,
        "nombreUsuario": nombreUsuario,
        "passwordUsuario": passwordUsuario,
      };
}
