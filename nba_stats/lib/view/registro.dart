// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nba_stats/controller/api_request.dart';
import 'package:nba_stats/view/login.dart';

import '../model/usuario.dart';

class RegistroState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Registro();
}

class Registro extends State<RegistroState> {
  final keyForm = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  String nombreUsuario = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro"),
      ),
      body: Padding(
        padding: EdgeInsets.all(50),
        child: Form(
            key: keyForm,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  child: TextFormField(
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
                ),
                SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  child: TextFormField(
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
                ),
                SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  child: TextFormField(
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
                ),
                SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (keyForm.currentState!.validate()) {
                      cambiarPagina(context, nombreUsuario, password);
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

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        nombreUsuario = "";
        password = "";
        passwordController.text = "";
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Error"),
      content: Text("El usuario ya existe."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  cambiarPagina(
      BuildContext context, String nombreUsuario, String password) async {
    String pass = generarHash(password);
    Usuario usuario = Usuario(
        usuarioId: 1, nombreUsuario: nombreUsuario, passwordUsuario: pass);
    int comprobar = await ApiService.crearUsuario(usuario);
    if (comprobar == 201) {
      usuario.passwordUsuario = password;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => LoginState(usuario: usuario),
        ),
      );
    } else if (comprobar == 400) {
      showAlertDialog(context);
    }
  }

  String generarHash(String pass) {
    final bytes = utf8.encode(pass);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
