import 'dart:convert';
//Este método convierte un json en objeto de la clase Acceso
Acceso accesoFromJson(String str) => Acceso.fromJson(json.decode(str));
//Este método convierte un objeto de la clase Acceso a json
String accesoToJson(Acceso data) => json.encode(data.toJson());
//Clase Acceso
class Acceso {
  //Atributos
  String nombreUsuario;
  String passwordUsuario;
  //Constructor
  Acceso({
    required this.nombreUsuario,
    required this.passwordUsuario,
  });
  //Este método permite construir un objeto de la clase Acceso haciendo uso del json
  factory Acceso.fromJson(Map<String, dynamic> json) => Acceso(
        nombreUsuario: json["nombreUsuario"],
        passwordUsuario: json["passwordUsuario"],
      );
  //Este método convierte un objeto de la clase Acceso a un mapa el cuál se convertirá en un json
  Map<String, dynamic> toJson() => {
        "nombreUsuario": nombreUsuario,
        "passwordUsuario": passwordUsuario,
      };
}
