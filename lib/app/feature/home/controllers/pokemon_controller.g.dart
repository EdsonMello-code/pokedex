// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PokemonController on _PokemonControllerBase, Store {
  final _$pokemonsAtom = Atom(name: '_PokemonControllerBase.pokemons');

  @override
  PokemonListModel get pokemons {
    _$pokemonsAtom.reportRead();
    return super.pokemons;
  }

  @override
  set pokemons(PokemonListModel value) {
    _$pokemonsAtom.reportWrite(value, super.pokemons, () {
      super.pokemons = value;
    });
  }

  final _$favoritePokemonsAtom =
      Atom(name: '_PokemonControllerBase.favoritePokemons');

  @override
  List<PokemonModel> get favoritePokemons {
    _$favoritePokemonsAtom.reportRead();
    return super.favoritePokemons;
  }

  @override
  set favoritePokemons(List<PokemonModel> value) {
    _$favoritePokemonsAtom.reportWrite(value, super.favoritePokemons, () {
      super.favoritePokemons = value;
    });
  }

  final _$startPokemonAsyncAction =
      AsyncAction('_PokemonControllerBase.startPokemon');

  @override
  Future<void> startPokemon() {
    return _$startPokemonAsyncAction.run(() => super.startPokemon());
  }

  final _$nextListPokemonAsyncAction =
      AsyncAction('_PokemonControllerBase.nextListPokemon');

  @override
  Future<void> nextListPokemon() {
    return _$nextListPokemonAsyncAction.run(() => super.nextListPokemon());
  }

  final _$setFavoritePokemonAsyncAction =
      AsyncAction('_PokemonControllerBase.setFavoritePokemon');

  @override
  Future setFavoritePokemon({required String pokemonUrl}) {
    return _$setFavoritePokemonAsyncAction
        .run(() => super.setFavoritePokemon(pokemonUrl: pokemonUrl));
  }

  final _$removeFavoritePokemonAsyncAction =
      AsyncAction('_PokemonControllerBase.removeFavoritePokemon');

  @override
  Future removeFavoritePokemon({required String pokemonUrl}) {
    return _$removeFavoritePokemonAsyncAction
        .run(() => super.removeFavoritePokemon(pokemonUrl: pokemonUrl));
  }

  @override
  String toString() {
    return '''
pokemons: ${pokemons},
favoritePokemons: ${favoritePokemons}
    ''';
  }
}
