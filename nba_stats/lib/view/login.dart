// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/usuario.dart';

class LoginState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Login();
}

class Login extends State<LoginState> {
  final keyForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    //Creamos objeto usuario con los datos pasados de la página de registro
    Usuario? usuario = ModalRoute.of(context)!.settings.arguments as Usuario?;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
              key: keyForm,
              child: Column(
                children: [
                  SizedBox( height: 10,),
                  Center(
                    child: Text("NBA Stats",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),),
                  ),
                  SizedBox(height: 200),
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Campo obligatorio";
                        }
                              
                        if (value != usuario?.nombreUsuario) {
                          return "Nombre de Usuario incorrecto";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          hintText: "Ingresa tu nombre de usuario aquí",
                          labelText: "Nombre de Usuario",
                          labelStyle: TextStyle(color: Colors.blue[200]), ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Campo obligatorio";
                        }
                              
                        if (value != usuario?.passwordUsuario) {
                          return "Contraseña incorrecta";
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Ingresa tu contraseña aquí",
                          labelText: "Contraseña",
                          labelStyle: TextStyle(color: Colors.blue[200])),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (keyForm.currentState!.validate()) {
                            guardarIsLogedInEnSharedPreferences(true);
                            cambiarPaginaApp(context);
                          } else {
                            print("Validación incorrecta");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white),
                        child: Text("Iniciar Sesión"),
                      ),
                      SizedBox(
                        height: 80.0,
                        width: 45.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          cambiarPagina(context);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white),
                        child: Text("Registrarse"),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }

  cambiarPagina(BuildContext context) {
    Navigator.of(context).pushNamed('/registro');
  }

  cambiarPaginaApp(BuildContext context) {
    Navigator.of(context).pushNamed('/home');
  }

  void guardarIsLogedInEnSharedPreferences(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogedIn', value);
  }
}
