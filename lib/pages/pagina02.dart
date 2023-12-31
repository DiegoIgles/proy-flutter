import 'package:flutter/material.dart';
import 'package:proy1/pages/pagHome.dart';
import 'package:proy1/pages/pagUsers.dart';
import 'package:proy1/pages/pagServicios.dart';
import 'package:proy1/pages/pagPagos.dart';
import 'package:proy1/pages/pagMiVehiculo.dart'; 
import 'package:proy1/pages/ordenTrabajo.dart';
import 'package:proy1/main.dart';
import 'package:proy1/controller/AuthController.dart';

void main() {
  runApp(const Pagina02());
}

class Pagina02 extends StatelessWidget {
  const Pagina02({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController _authController = AuthController();

    return WillPopScope(
      onWillPop: () async {
        // Muestra el cuadro de diálogo y retorna true si el usuario confirma la salida
        bool exitConfirmed = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('¿Estás seguro de que quieres salir?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Cancelar'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Salir'),
              ),
            ],
          ),
        );

        return exitConfirmed ?? false;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MyHomePage(
          title: 'TALLER MECÁNICO',
          onLogout: () {
            _authController.logout();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
              (route) => false,
            );
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.onLogout});
  final String title;
  final VoidCallback onLogout;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _paginaActual = 0;
  List<Widget> _paginas = [
    PaginaHome(),
    PaginaUsers(),
    Servicios(),
    MiVehiculoPage(),
    PagosPage(),
    OrdenesTrabajoPage(),
  ];

  void _cambiarPagina(int index) {
    setState(() {
      _paginaActual = index;
      Navigator.pop(context); // Cierra el menú desplegable
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "TALLER MECÁNICO",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
      body: _paginas[_paginaActual],
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Inicio"),
              onTap: () {
                _cambiarPagina(0);
              },
            ),
            ListTile(
              leading: Icon(Icons.supervised_user_circle),
              title: Text("Perfil"),
              onTap: () {
                _cambiarPagina(1);
              },
            ),
            ListTile(
              leading: Icon(Icons.build_rounded),
              title: Text("Servicios"),
              onTap: () {
                _cambiarPagina(2);
              },
            ),
            ListTile(
              leading: Icon(Icons.directions_car),
              title: Text("Mi Vehículo"), // Agrega la nueva opción
              onTap: () {
                _cambiarPagina(3);
              },
            ),
            ListTile(
              leading: Icon(Icons.credit_card),
              title: Text("Mis Pagos"), // Agrega la nueva opción
              onTap: () {
                _cambiarPagina(4);
              },
            ),
            ListTile(
              leading: Icon(Icons.construction),
              title: Text("Orden de Trabajo"), // Agrega la nueva opción
              onTap: () {
                _cambiarPagina(5);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Cerrar Sesión"),
              onTap: widget.onLogout,
            ),
          ],
        ),
      ),
    );
  }
}
