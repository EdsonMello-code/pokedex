import 'package:mobx/mobx.dart';
import 'package:pokedex/app/core/repositories/pokemon_core_repository.dart';
import 'package:pokedex/app/feature/home/models/pokemon_list_model.dart';
import 'package:pokedex/app/feature/home/models/pokemon_model.dart';
import 'package:pokedex/app/feature/home/repositories/pokemon_repository.dart';

part 'pokemon_controller.g.dart';

class PokemonController = _PokemonControllerBase with _$PokemonController;

abstract class _PokemonControllerBase with Store {
  final PokemonRepository pokemonRepository;

  final PokemonCoreRepository pokemonCoreRepoitory;

  _PokemonControllerBase(
      {required this.pokemonDetailsRepository,
      required this.pokemonCoreRepoitory,
      required this.pokemonRepository});

  final PokemonCoreRepository pokemonDetailsRepository;

  @observable
  PokemonListModel pokemons = PokemonListModel(next: '', prev: '', result: []);

  @observable
  List<PokemonModel> favoritePokemons = [];

  @action
  Future<void> startPokemon() async {
    pokemons = await pokemonRepository.listPokemons();
  }

  @action
  Future<void> nextListPokemon() async {
    final nextPokemons =
        await pokemonRepository.listPokemons(url: pokemons.next);
    final result = pokemons.result;
    nextPokemons.result.addAll(result);

    pokemons = nextPokemons;
  }

  @action
  setFavoritePokemon({required String pokemonUrl}) async {
    final newPokemon = await pokemonCoreRepoitory.fechPokemon(pokemonUrl);
    final pokemonListFiltered = favoritePokemons
        .where((pokemon) => pokemon.title == newPokemon.title)
        .toList();

    if (pokemonListFiltered.isEmpty) {
      final copyList = favoritePokemons.map((e) => e).toList();
      copyList.add(newPokemon);
      favoritePokemons = copyList;
    }
  }

  @action
  removeFavoritePokemon({required String pokemonUrl}) async {
    final newPokemon = await pokemonCoreRepoitory.fechPokemon(pokemonUrl);

    final pokemonListFiltered = favoritePokemons
        .where((pokemon) => pokemon.title == newPokemon.title)
        .toList();
    if (pokemonListFiltered.isNotEmpty) {
      favoritePokemons = favoritePokemons
          .where((element) => pokemonListFiltered[0].title != element.title)
          .toList();
    }
  }

  Future<bool> searchPokemon({required String pokemonName}) async {
    final pokemonFiltered = await pokemonCoreRepoitory
        .searchPokemon('${pokemonRepository.baseUrl}/$pokemonName');
    return pokemonFiltered;
  }
}
