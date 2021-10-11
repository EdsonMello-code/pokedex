import 'package:mobx/mobx.dart';
import 'package:pokedex/app/core/repositories/pokemon_core_repository.dart';
import 'package:pokedex/app/feature/home/models/pokemon_model.dart';
import 'package:pokedex/app/feature/pokemon_details/repositories/pokemon_details_repository.dart';

part 'pokemon_details_controller.g.dart';

class PokemonDetailsController = _PokemonDetailsControllerBase
    with _$PokemonDetailsController;

abstract class _PokemonDetailsControllerBase with Store {
  final PokemonCoreRepository pokemonCoreRepository;

  final PokemonDetailsRepository pokemonDetailsRepository;

  _PokemonDetailsControllerBase(
      {required this.pokemonCoreRepository,
      required this.pokemonDetailsRepository});

  @observable
  PokemonModel pokemon =
      PokemonModel(urlImage: '', title: '', skills: [], weight: 0, height: 0);

  @action
  getPokemon(url) async {
    pokemon = await pokemonCoreRepository.fechPokemon(url);
  }

  @computed
  bool get isFavorited => pokemon.isFavorite;

  @observable
  String city = '';

  @action
  getCity() async {
    city = await pokemonDetailsRepository.fetchCity();
  }
}
