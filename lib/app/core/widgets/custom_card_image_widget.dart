import 'package:flutter/material.dart';
import 'package:pokedex/app/feature/pokemon_details/views/pokemon_details_view.dart';
import 'package:pokedex/app/feature/home/models/pokemon_with_name_url.dart';

class CustomCardImageWidget extends StatefulWidget {
  final PokemonWithNameUrl pokemonWithNameUrl;

  final void Function() turnOnFavorite;
  final void Function() turnOffFavorite;

  CustomCardImageWidget({
    Key? key,
    required this.pokemonWithNameUrl,
    required this.turnOnFavorite,
    required this.turnOffFavorite,
  }) : super(key: key);

  @override
  _CustomCardImageWidgetState createState() => _CustomCardImageWidgetState();
}

class _CustomCardImageWidgetState extends State<CustomCardImageWidget> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return PokemonDetailsView(
            pokemonUrl: widget.pokemonWithNameUrl.url,
          );
        }));
      },
      child: Card(
        color: theme.primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              widget.pokemonWithNameUrl.name,
              style: TextStyle(
                  color: theme.scaffoldBackgroundColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 28),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    isFavorite = !isFavorite;
                    if (isFavorite) {
                      widget.turnOffFavorite();
                    } else {
                      widget.turnOnFavorite();
                    }
                  });
                },
                icon: !isFavorite
                    ? const Icon(
                        Icons.star,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ))
          ],
        ),
      ),
    );
  }
}
