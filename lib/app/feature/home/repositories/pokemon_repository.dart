import 'package:dio/dio.dart';
import 'package:pokedex/app/feature/home/models/pokemon_list_model.dart';

class PokemonRepository {
  final Dio dio;

  get baseUrl => 'https://pokeapi.co/api/v2/pokemon';

  PokemonRepository({required this.dio});

  Future<PokemonListModel> listPokemons({String? url}) async {
    final response = await dio.get(url ?? baseUrl);
    final resultMap = response.data as Map<String, dynamic>;

    return PokemonListModel.fromMap(map: resultMap);
  }
}
