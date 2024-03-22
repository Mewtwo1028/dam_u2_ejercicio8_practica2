import 'package:flutter/material.dart';
import 'package:dam_u2_ejercicio8_practica2/ListaPokemon.dart';
import 'package:dam_u2_ejercicio8_practica2/pokemon.dart';

class Registrar extends StatefulWidget {
  const Registrar({Key? key}) : super(key: key);

  @override
  State<Registrar> createState() => _RegistrarState();
}

class _RegistrarState extends State<Registrar> {
  ListaPokemon lpkm = ListaPokemon();
  final controladorNombre = TextEditingController();
  final controladorPokedex = TextEditingController();
  final controladorTipo = TextEditingController();
  final controladorGeneracion = TextEditingController();

  @override
  void initState() {
    super.initState();
    cargarDatos();
  }

  Future<void> cargarDatos() async {
    await lpkm.cargarDatos();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.all(50),
        children: [
          TextField(controller: controladorNombre, decoration: const InputDecoration(labelText: 'Pokémon')),
          TextField(controller: controladorPokedex,decoration: const InputDecoration(labelText: 'Pokédex')),
          TextField(controller: controladorTipo,decoration: const InputDecoration(labelText: 'Tipo')),
          TextField(controller: controladorGeneracion,decoration: const InputDecoration(labelText: 'Generación')),
          SizedBox(height: 20,),
          ElevatedButton(
            onPressed: () async {
              Pokemon pkm = Pokemon(
                pokemon: controladorNombre.text,
                pokedex: controladorPokedex.text,
                tipo: controladorTipo.text,
                generacion: controladorGeneracion.text,
              );
              lpkm.nuevo(pkm);
              lpkm.guardarArchivo();
              setState(() {
                controladorNombre.clear();
                controladorPokedex.clear();
                controladorTipo.clear();
                controladorGeneracion.clear();
              });
            },
            child: Text("Guardar"),
          ),
          Image.asset("assets/RotomDex.png"),
        ],
      ),
    );
  }
}
