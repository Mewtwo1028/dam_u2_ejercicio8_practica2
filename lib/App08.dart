import 'package:flutter/material.dart';
import 'package:dam_u2_ejercicio8_practica2/ListaPokemon.dart';
import 'package:dam_u2_ejercicio8_practica2/pokemon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'listar.dart';
import 'liberar.dart';
import 'registrar.dart';
import 'login.dart';
import 'actualizar.dart';

class App08 extends StatefulWidget {
  const App08({Key? key}) : super(key: key);

  @override
  _App08State createState() => _App08State();
}

class _App08State extends State<App08> {
  final controlador = TextEditingController();
  int _indice = 0; // Cambiado el valor inicial para que muestre el registro por defecto
  ListaPokemon lpkm = ListaPokemon();

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  // Método para cargar los datos desde SharedPreferences
  Future<void> _cargarDatos() async {
    try {
      await lpkm.cargarDatos();
      setState(() {
        // Actualiza el estado para que el widget se reconstruya con los datos cargados
      });
    } catch (e) {
      print("Error al cargar los datos: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Práctica 08"),
        backgroundColor: Colors.red,
      ),
      body: _widgetOptions.elementAt(_indice), // Mostrar el widget según el índice seleccionado
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("POKÉDEX", style: TextStyle(color: Colors.white, fontSize: 20),),
                  //Image.asset("assets/RotomDex.png"),
                ],
              ),
              decoration: BoxDecoration(color: Colors.red),
            ),
            SizedBox(height: 40,),
            itemDrawer(1, Icons.add, "Registrar en el Pokédex"),
            itemDrawer(2, Icons.list, "Listar Pokédex"),
            itemDrawer(3, Icons.delete_forever, "Liberar Pokémon"),
            itemDrawer(4, Icons.update, "Actualizar Pokémon"),
            itemDrawer(5, Icons.logout, "Cerrar Sesión"),
          ],
        ),
      ),
    );
  }

  // Lista de widgets correspondientes a cada ítem del BottomNavigationBar
  static List<Widget> _widgetOptions = <Widget>[
    Login(),
    Registrar(),
    Listar(),
    Liberar(),
    Actualizar(),
    Login(),
  ];

  // Método para cambiar el índice del widget seleccionado en el BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _indice = index;
    });
  }

  // Método para construir cada elemento del Drawer
  Widget itemDrawer(int indice, IconData icono, String texto) {
    return ListTile(
      title: Row(
        children: [
          Expanded(child: Icon(icono)),
          Expanded(child: Text(texto), flex: 2,)
        ],
      ),
      onTap: () {
        setState(() {
          _indice = indice; // Cambiar el índice al seleccionar un elemento del Drawer
        });
        Navigator.pop(context); // Cierra el Drawer
      },
    );
  }
}
