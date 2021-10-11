import 'package:pokedex/app/feature/home/models/pokemon_with_name_url.dart';

class PokemonListModel {
  final String next;
  final String? prev;
  List<PokemonWithNameUrl> result;

  PokemonListModel({
    required this.next,
    required this.prev,
    required this.result,
  });

  factory PokemonListModel.fromMap({required Map<String, dynamic> map}) {
    final result = map['results'] as List;

    return PokemonListModel(
        next: map['next'],
        prev: map['previous'],
        result:
            result.map((map) => PokemonWithNameUrl.fromMap(map: map)).toList());
  }

  void addAll(PokemonListModel pokemonListModel) {}
}
