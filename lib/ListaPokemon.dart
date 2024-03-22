import 'package:dam_u2_ejercicio8_practica2/pokemon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListaPokemon {
  List<Pokemon> data = [];

  Pokemon toPokemon(String cod) {
    List<String> res = cod.split("&&");
    Pokemon pkm = Pokemon(
      pokemon: res[0],
      pokedex: res[1],
      tipo: res[2],
      generacion: res[3],
    );
    return pkm;
  }

  Future<void> guardarArchivo() async {
    SharedPreferences almacen = await SharedPreferences.getInstance();
    List<String> buffer = [];
    data.forEach((element) {
      buffer.add(element.toString());
    });
    await almacen.setStringList("buffer", buffer);
  }

  Future<void> cargarDatos() async {
    SharedPreferences almacen = await SharedPreferences.getInstance();
    List<String>? buffer = almacen.getStringList("buffer");
    if (buffer != null) {
      data.clear();
      buffer.forEach((element) {
        data.add(toPokemon(element));
      });
    }
  }

  void nuevo(Pokemon pkm) {
    data.add(pkm);
  }

  void actualizar(Pokemon pkm, int pos) {
    data[pos] = pkm;
  }

  void eliminar(int pos) {
    data.removeAt(pos);
  }
}
