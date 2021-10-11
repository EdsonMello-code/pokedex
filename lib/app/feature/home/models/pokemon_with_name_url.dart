class PokemonWithNameUrl {
  final String url;
  final String name;

  const PokemonWithNameUrl({required this.url, required this.name});
  factory PokemonWithNameUrl.fromMap({required Map<String, dynamic> map}) {
    return PokemonWithNameUrl(
      url: map['url'],
      name: map['name'],
    );
  }
}
