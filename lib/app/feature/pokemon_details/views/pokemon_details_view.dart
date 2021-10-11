import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pokedex/app/core/repositories/pokemon_core_repository.dart';
import 'package:pokedex/app/core/widgets/stats_widget.dart';
import 'package:pokedex/app/feature/home/views/home_view.dart';
import 'package:pokedex/app/feature/pokemon_details/controllers/pokemon_details_controller.dart';
import 'package:pokedex/app/feature/pokemon_details/repositories/pokemon_details_repository.dart';

class PokemonDetailsView extends StatefulWidget {
  final String pokemonUrl;

  const PokemonDetailsView({Key? key, required this.pokemonUrl})
      : super(key: key);

  @override
  PokemonDetailsViewState createState() => PokemonDetailsViewState();
}

class PokemonDetailsViewState extends State<PokemonDetailsView> {
  late final PokemonDetailsController pokemonDetailsController;

  final sizeOfApp = 100.0;

  @override
  void initState() {
    pokemonDetailsController = PokemonDetailsController(
      pokemonCoreRepository: PokemonCoreRepository(
        dio: Dio(),
      ),
      pokemonDetailsRepository: PokemonDetailsRepository(dio: Dio()),
    );

    pokemonDetailsController.getPokemon(widget.pokemonUrl);

    super.initState();
  }

  Widget _buildDialog({required String city}) {
    return Dialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Container(
        width: 200,
        height: 210,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Obrigado pela preferência, volte sempre.',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Iremos entregar na sua cidade: $city.',
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: IconButton(
                color: Colors.white,
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (_) {
                    return const HomeView();
                  }));
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Observer(
        builder: (context) {
          return Container(
            height: size.height - sizeOfApp,
            width: size.width,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
            child: SingleChildScrollView(
              clipBehavior: Clip.none,
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              child: Column(
                children: [
                  pokemonDetailsController.pokemon.urlImage != ''
                      ? Image.network(
                          pokemonDetailsController.pokemon.urlImage,
                          width: 100,
                          height: 100,
                        )
                      : const Padding(
                          padding: EdgeInsets.only(top: 50.0),
                          child: CircularProgressIndicator(),
                        ),
                  Text(
                    pokemonDetailsController.pokemon.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Column(
                    children: pokemonDetailsController.pokemon.skills
                        .map(
                          (stat) => StatsWidget(
                            label: stat['stat']['name'],
                            value: stat['base_stat'],
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: size.width,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () async {
                          await pokemonDetailsController.getCity();
                          showDialog(
                              context: context,
                              builder: (_) {
                                return _buildDialog(
                                    city: pokemonDetailsController.city);
                              });
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(theme.primaryColor)),
                        child: const Text(
                          'Comprar',
                          style: TextStyle(fontSize: 24),
                        )),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
