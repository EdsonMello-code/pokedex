// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_details_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PokemonDetailsController on _PokemonDetailsControllerBase, Store {
  Computed<bool>? _$isFavoritedComputed;

  @override
  bool get isFavorited =>
      (_$isFavoritedComputed ??= Computed<bool>(() => super.isFavorited,
              name: '_PokemonDetailsControllerBase.isFavorited'))
          .value;

  final _$pokemonAtom = Atom(name: '_PokemonDetailsControllerBase.pokemon');

  @override
  PokemonModel get pokemon {
    _$pokemonAtom.reportRead();
    return super.pokemon;
  }

  @override
  set pokemon(PokemonModel value) {
    _$pokemonAtom.reportWrite(value, super.pokemon, () {
      super.pokemon = value;
    });
  }

  final _$cityAtom = Atom(name: '_PokemonDetailsControllerBase.city');

  @override
  String get city {
    _$cityAtom.reportRead();
    return super.city;
  }

  @override
  set city(String value) {
    _$cityAtom.reportWrite(value, super.city, () {
      super.city = value;
    });
  }

  final _$getPokemonAsyncAction =
      AsyncAction('_PokemonDetailsControllerBase.getPokemon');

  @override
  Future getPokemon(dynamic url) {
    return _$getPokemonAsyncAction.run(() => super.getPokemon(url));
  }

  final _$getCityAsyncAction =
      AsyncAction('_PokemonDetailsControllerBase.getCity');

  @override
  Future getCity() {
    return _$getCityAsyncAction.run(() => super.getCity());
  }

  @override
  String toString() {
    return '''
pokemon: ${pokemon},
city: ${city},
isFavorited: ${isFavorited}
    ''';
  }
}
