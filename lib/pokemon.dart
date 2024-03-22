class Pokemon {
  String pokemon;
  String pokedex;
  String tipo;
  String generacion;

  Pokemon({
    required this.pokemon,
    required this.pokedex,
    required this.tipo,
    required this.generacion,
  });

  @override
  String toString() {
    return '$pokemon&&$pokedex&&$tipo&&$generacion';
  }
}
