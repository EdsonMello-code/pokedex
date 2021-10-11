import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pokedex/app/core/repositories/pokemon_core_repository.dart';
import 'package:pokedex/app/core/widgets/custom_card_image_widget.dart';
import 'package:pokedex/app/feature/home/controllers/pokemon_controller.dart';
import 'package:pokedex/app/feature/home/models/pokemon_model.dart';
import 'package:pokedex/app/feature/home/repositories/pokemon_repository.dart';
import 'package:pokedex/app/feature/pokemon_details/views/pokemon_details_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final double appBarSize = 160.0;
  final PokemonController pokemonController = PokemonController(
      pokemonRepository: PokemonRepository(dio: Dio()),
      pokemonCoreRepoitory: PokemonCoreRepository(dio: Dio()),
      pokemonDetailsRepository: PokemonCoreRepository(dio: Dio()));

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late final Future<PokemonModel> pokemonsFavorited;
  bool isFavorite = false;

  String pokemonName = '';

  @override
  void initState() {
    pokemonController.startPokemon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final styles = Theme.of(context);
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Drawer(
        child: Observer(builder: (context) {
          return Container(
            color: styles.scaffoldBackgroundColor,
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.only(top: 16),
                    height: size.height - 70,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: const AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        clipBehavior: Clip.none,
                        itemCount: pokemonController.favoritePokemons.length,
                        itemBuilder: (_, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (_) {
                                return PokemonDetailsView(
                                    pokemonUrl: pokemonController
                                            .favoritePokemons[index].url ??
                                        '');
                              }));
                            },
                            child: SizedBox(
                              width: size.width,
                              height: 100,
                              child: Row(
                                children: [
                                  pokemonController.favoritePokemons[index]
                                          .urlImage.isNotEmpty
                                      ? Image.network(pokemonController
                                          .favoritePokemons[index].urlImage)
                                      : Container(),
                                  Text(
                                    pokemonController
                                        .favoritePokemons[index].title,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 24),
                                  )
                                ],
                              ),
                            ),
                          );
                        })),
              ],
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.shopping_cart),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () async {
          _scaffoldKey.currentState?.openEndDrawer();
        },
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[Container()],
        toolbarHeight: appBarSize,
        elevation: 0,
        title: Column(
          children: [
            Image.asset('assets/images/logo.png'),
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) async {
                pokemonName = value;
              },
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  onPressed: () async {
                    if (pokemonName == '') return;
                    final pokemon = await pokemonController.searchPokemon(
                        pokemonName: pokemonName);
                    if (pokemon == true) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) {
                            return PokemonDetailsView(
                                pokemonUrl:
                                    'https://pokeapi.co/api/v2/pokemon/${pokemonName}');
                          },
                        ),
                      );
                    }
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
                label: const Text(
                  'Search',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pokedex',
                style: styles.textTheme.headline1,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: size.width,
                height: size.height - appBarSize - statusBarHeight - 40,
                child: Observer(builder: (context) {
                  return Container(
                    padding: const EdgeInsets.only(bottom: 36),
                    child: RefreshIndicator(
                      onRefresh: pokemonController.nextListPokemon,
                      child: GridView.builder(
                          physics: const AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics()),
                          itemCount: pokemonController.pokemons.result.length,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 300,
                                  childAspectRatio: 2 / 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemBuilder: (_, index) {
                            final pokemons = pokemonController.pokemons;

                            return CustomCardImageWidget(
                              turnOffFavorite: () async {
                                await pokemonController.setFavoritePokemon(
                                    pokemonUrl: pokemons.result[index].url);
                              },
                              turnOnFavorite: () async {
                                await pokemonController.removeFavoritePokemon(
                                    pokemonUrl: pokemons.result[index].url);
                              },
                              pokemonWithNameUrl: pokemons.result[index],
                            );
                          }),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
