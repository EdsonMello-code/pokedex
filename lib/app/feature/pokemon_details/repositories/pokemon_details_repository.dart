import 'package:dio/dio.dart';
import 'package:pokedex/app/feature/home/models/pokemon_model.dart';

class PokemonDetailsRepository {
  final Dio dio;

  get pokemonBaseUrl => 'https://pokeapi.co/api/v2/pokemon';

  PokemonDetailsRepository({required this.dio});
  Future<String> fetchCity() async {
    final city = await dio.get('http://ip-api.com/json/?fields=61439');
    return city.data['city'] as String;
  }

  Future<PokemonModel> getPokemon({required String pokemonName}) async {
    final response = await dio.get('$pokemonBaseUrl/$pokemonName');
    final data = response.data as Map<String, dynamic>;

    return PokemonModel.fromMap(map: data);
  }
}
