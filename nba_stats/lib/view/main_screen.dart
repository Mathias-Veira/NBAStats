import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nba_stats/controller/api_request.dart';
import 'package:nba_stats/model/usuario.dart';
import 'package:nba_stats/view/standings.dart';

import 'games.dart';
import 'home.dart';
import 'players.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _HomeState();
}

class _HomeState extends State<MainScreen> {
    int selectedIndex = 0;
  Usuario? usuario;
  Future<Usuario>? user;

  @override
  void initState() {
    super.initState();
    obtenerUsuario();
  }

  Future<void> obtenerUsuario() async {
    try {
      Usuario usuarioObtenido = await ApiService.obtenerUsuario(usuario?.nombreUsuario ?? '');

      setState(() {
        usuario = usuarioObtenido;
      });
    } catch (error) {
      print('Error al obtener el usuario: $error');
    }
  }

  cambiarPagina(BuildContext context, String route) {
    Navigator.of(context).pushNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      const Home(),
      const Games(),
      const standings(),
      const Players(),
    ];
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),
      drawer: Drawer(
        backgroundColor: Colors.teal[200],
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.teal[100]),
              accountName: Text(
                usuario?.nombreUsuario?? '',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              accountEmail: const Text(''),
              currentAccountPictureSize: const Size(55, 55),
              currentAccountPicture: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
                child: const Center(
                  child: Icon(
                    Icons.person,
                    size: 40,
                  ),
                ),
              ),
            ),
            ListTile(
              title: const Text(
                "Stats Leaders",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
              onTap: () => cambiarPagina(context, '/statsLeaders'),
            ),
            ListTile(
              title: const Text(
                "PlayOffs Series",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
              onTap: () => cambiarPagina(context, '/playoffsSeries'),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            activeIcon: Icon(
              Icons.home_filled,
              color: Colors.white,
            ),
            label: 'Home',
            backgroundColor: Colors.grey[850],
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.sports_basketball,
              color: Colors.white,
            ),
            activeIcon: Icon(
              Icons.sports_basketball_outlined,
              color: Colors.white,
            ),
            label: 'Games',
            backgroundColor: Colors.grey[850],
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star_border,
              color: Colors.white,
            ),
            activeIcon: Icon(
              Icons.star,
              color: Colors.white,
            ),
            label: 'Standings',
            backgroundColor: Colors.grey[850],
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.group_outlined,
              color: Colors.white,
            ),
            activeIcon: Icon(
              Icons.group,
              color: Colors.white,
            ),
            label: 'Players',
            backgroundColor: Colors.grey[850],
          ),
        ],
      ),
    );
  }
}
