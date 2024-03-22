import 'package:flutter/material.dart';
import 'ListaPokemon.dart';

class Liberar extends StatefulWidget {
  const Liberar({Key? key}) : super(key: key);

  @override
  State<Liberar> createState() => _LiberarState();
}

class _LiberarState extends State<Liberar> {
  ListaPokemon lp = ListaPokemon();
  int? selectedIndex; // Índice del Pokémon seleccionado

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liberar Pokémon"),
      ),
      body: FutureBuilder(
        future: lp.cargarDatos(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Selecciona un Pokémon para liberar:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: lp.data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(lp.data[index].toString()),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("¿Estás seguro que deseas liberar este Pokémon?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          lp.eliminar(index); // Eliminar el Pokémon seleccionado
                                          lp.guardarArchivo(); // Guardar la lista actualizada
                                          selectedIndex = null; // Reiniciar el índice seleccionado
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
                        ),
                        onTap: () {
                          setState(() {
                            selectedIndex = index; // Al hacer tap en un Pokémon, se guarda su índice
                          });
                        },
                        selected: selectedIndex == index, // Resalta el Pokémon seleccionado
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
