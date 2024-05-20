// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:nba_stats/controller/api_request.dart';

import '../model/usuario.dart';


class RegistroState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Registro();
}

class Registro extends State<RegistroState> {
  final keyForm = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  String nombreUsuario = "";
  String correo = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro"),
      ),
      body: Padding(
        padding: EdgeInsets.all(100),
        child: Form(
            key: keyForm,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Campo obligatorio";
                    }

                    if (!isValidEmail(value)) {
                      return "Correo no válido";
                    }
                    correo = value;
                    return null;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Nombre Usuario",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Campo obligatorio";
                    }
                    nombreUsuario = value;
                    return null;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Contraseña",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Campo obligatorio";
                    }

                    if (value.length < 12) {
                      return "La contraseña debe ser de 12 caracteres o más";
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Confirmar Contraseña",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Campo obligatorio";
                    }

                    if (value != passwordController.text) {
                      return "Las contraseñas son distintas";
                    }
                    password = value;
                    return null;
                  },
                  obscureText: true,
                ),
                SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (keyForm.currentState!.validate()) {
                      cambiarPagina(context, nombreUsuario, correo, password);
                    } else {
                      print("Formulario incorrecto");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white),
                  child: Text("Registrarse"),
                ),
              ],
            )),
      ),
    );
  }

  bool isValidEmail(String email) {
    String regex = r'^[A-Za-z0-9+_.-]+@(.+)$';
    RegExp regExp = RegExp(regex);
    return regExp.hasMatch(email);
  }

  cambiarPagina(BuildContext context, String nombreUsuario, String correo,
      String password) async{

    Usuario usuario = Usuario(usuarioId: 1, nombreUsuario: nombreUsuario, passwordUsuario: password,correoUsuario: correo);
    int comprobar = await ApiService.crearUsuario(usuario);
    if(comprobar == 201){
      Navigator.of(context).pushNamed('/login',
        arguments: Usuario(usuarioId: 1, nombreUsuario: nombreUsuario, passwordUsuario: password, correoUsuario: correo));
    }
    
  }
}
