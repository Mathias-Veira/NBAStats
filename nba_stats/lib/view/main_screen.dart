import 'package:flutter/material.dart';
import 'package:nba_stats/controller/api_request.dart';
import 'package:nba_stats/model/usuario.dart';
import 'package:nba_stats/view/mvp.dart';
import 'package:nba_stats/view/standings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/search_mvp_delegate.dart';
import 'games.dart';
import 'home.dart';
import 'players.dart';

class MainScreen extends StatefulWidget {
  final String nombreUsuario;
  const MainScreen({super.key, required this.nombreUsuario});
  @override
  State<MainScreen> createState() => _HomeState(nombreUsuario: nombreUsuario);
}

class _HomeState extends State<MainScreen> {
  final String nombreUsuario;
  int selectedIndex = 0;
  Usuario? usuario;
  Future<Usuario>? user;
  final PageController _pageController = PageController();

  _HomeState({required this.nombreUsuario});

  @override
  void initState() {
    super.initState();
    obtenerUsuario();
  }

  Future<void> obtenerUsuario() async {
    try {
      Usuario usuarioObtenido = await ApiService.obtenerUsuario(nombreUsuario);

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

  cambiarAElegirMVP(BuildContext context, int idUsuario){
    Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => MVP(user: usuario,),
    settings: RouteSettings(
      arguments: usuario
    ),
  ),);
  }

  logOut(BuildContext context, String route) {
    userLogOut();
    Navigator.of(context).pushNamed(route);
  }

  Future<void> userLogOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      const Home(),
      const Games(),
      const Players(),
      const standings(),
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
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
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
                usuario?.nombreUsuario ?? '',
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
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              leading: const Icon(
                Icons.bar_chart,
                color: Colors.white,
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
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              leading: const Icon(
                Icons.emoji_events,
                color: Colors.white,
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
              onTap: () => cambiarPagina(context, '/playoffsSeries'),
            ),

            ListTile(
              title: const Text(
                "Your MVP",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              leading: const Icon(
                Icons.star,
                color: Colors.white,
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
              onTap: () => cambiarAElegirMVP(context, usuario!.usuarioId),
            ),

            ListTile(
              title: const Text(
                "Your NBA Champion",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              leading: const Icon(
                Icons.emoji_events,
                color: Colors.white,
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
              onTap: () => cambiarPagina(context, '/champion'),
            ),
            ListTile(
              title: const Text(
                "Log Out",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              leading: const Icon(
                Icons.output_rounded,
                color: Colors.white,
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
              onTap: () => logOut(context, '/login'),
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
            _pageController.jumpToPage(value);
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
        ],
      ),
    );
  }
}
