import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pokedex/app/feature/home/models/pokemon_model.dart';

class PokemonCoreRepository {
  final Dio dio;

  PokemonCoreRepository({required this.dio});

  Future<PokemonModel> fechPokemon(url) async {
    final pokemonMap = await dio.get(url);

    return PokemonModel.fromMap(map: pokemonMap.data, url: url);
  }

  Future<bool> searchPokemon(url) async {
    try {
      final pokemonMap = await dio.get(url);

      return pokemonMap.statusCode == 404 ? false : true;
    } on DioError catch (e) {
      debugPrint(e.message);
    }

    return false;
  }
}
