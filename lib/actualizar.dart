import 'package:flutter/material.dart';
import 'package:dam_u2_ejercicio8_practica2/ListaPokemon.dart';
import 'package:dam_u2_ejercicio8_practica2/pokemon.dart';

class Actualizar extends StatefulWidget {
  const Actualizar({Key? key}) : super(key: key);

  @override
  State<Actualizar> createState() => _ActualizarState();
}

class _ActualizarState extends State<Actualizar> {
  ListaPokemon lp = ListaPokemon();
  final controladorNombre = TextEditingController();
  final controladorPokedex = TextEditingController();
  final controladorTipo = TextEditingController();
  final controladorGeneracion = TextEditingController();

  Pokemon? pokemonSeleccionado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actualizar Pokémon'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nuevo Pokémon"),
            SizedBox(
              height: 20,
            ),
            TextField(
                controller: controladorNombre,
                decoration: const InputDecoration(labelText: 'Nombre')),
            TextField(
                controller: controladorPokedex,
                decoration: const InputDecoration(labelText: 'Pokédex')),
            TextField(
                controller: controladorTipo,
                decoration: const InputDecoration(labelText: 'Tipo')),
            TextField(
                controller: controladorGeneracion,
                decoration: const InputDecoration(labelText: 'Generación')),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                          "¿Estás seguro que deseas actualizar a tu Pokémon?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              Pokemon pkm = Pokemon(
                                pokemon: controladorNombre.text,
                                pokedex: controladorPokedex.text,
                                tipo: controladorTipo.text,
                                generacion: controladorGeneracion.text,
                              );
                              lp.nuevo(pkm);
                              lp.guardarArchivo();
                              lp.cargarDatos().then((_) {
                                setState(() {});
                              });
                            });
                            Navigator.of(context).pop();
                          },
                          child: Text("Sí"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Cancelar"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text("Actualizar"),
            ),
            SizedBox(
              height: 40,
            ),
            Text("Pokémon Registrados:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: FutureBuilder(
                future:
                    lp.cargarDatos(), // Cargar los datos de la lista de Pokémon
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      itemCount: lp.data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(lp.data[index].pokemon),
                          subtitle: Text("Pokédex: ${lp.data[index].pokedex}"),
                          trailing: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              setState(() {
                                pokemonSeleccionado = lp.data[index];
                                lp.eliminar(index);

                                controladorNombre.text =
                                    pokemonSeleccionado!.pokemon;
                                controladorPokedex.text =
                                    pokemonSeleccionado!.pokedex;
                                controladorTipo.text =
                                    pokemonSeleccionado!.tipo;
                                controladorGeneracion.text =
                                    pokemonSeleccionado!.generacion;

                                lp.actualizar(pokemonSeleccionado!, index);
                                lp.guardarArchivo();
                                lp.cargarDatos();
                              });
                            },
                          ),
                        );
                      },
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
