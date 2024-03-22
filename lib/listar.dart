import 'package:flutter/material.dart';
import 'ListaPokemon.dart';
import 'pokemon.dart';

class Listar extends StatefulWidget {
  const Listar({Key? key}) : super(key: key);

  @override
  State<Listar> createState() => _ListarState();
}

class _ListarState extends State<Listar> {
  ListaPokemon lpkm = ListaPokemon();
  List<Pokemon> listaPokemones = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    cargarPokemones();
  }

  Future<void> cargarPokemones() async {
    await lpkm.cargarDatos();
    setState(() {
      listaPokemones = lpkm.data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: listaPokemones.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Pokemon: ${listaPokemones[index].pokemon}, Generación: ${listaPokemones[index].generacion}, Tipo: ${listaPokemones[index].tipo}'),
            subtitle: Text('Pokédex: ${listaPokemones[index].pokedex}'),
          );
        },
      ),
    );
  }
}
