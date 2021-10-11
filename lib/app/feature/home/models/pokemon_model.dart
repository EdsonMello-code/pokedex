import 'dart:convert';

class PokemonModel {
  final String urlImage;
  final String title;
  final List skills;
  bool isFavorite;
  final int weight;
  final int height;
  final String? url;

  PokemonModel({
    this.url,
    required this.urlImage,
    required this.title,
    required this.skills,
    this.isFavorite = false,
    required this.weight,
    required this.height,
  });

  PokemonModel copyWith(
      {String? urlImage,
      String? title,
      List? skills,
      bool? isFavorite,
      int? weight,
      int? height,
      String? url}) {
    return PokemonModel(
        urlImage: urlImage ?? this.urlImage,
        title: title ?? this.title,
        skills: skills ?? this.skills,
        weight: weight ?? this.weight,
        height: height ?? this.height,
        isFavorite: isFavorite ?? this.isFavorite,
        url: url ?? this.url);
  }

  factory PokemonModel.fromMap(
      {required Map<String, dynamic> map, String? url}) {
    final stats = map['stats'] as List;
    return PokemonModel(
        urlImage: map['sprites']['front_default'],
        title: map['name'],
        skills: stats,
        weight: map['weight'],
        height: map['height'],
        url: url);
  }

  Map<String, dynamic> toMap() {
    final map = {
      'urlImage': urlImage,
      'title': title,
      'skills': skills,
      'isFavorite': isFavorite,
      'weight': weight,
      'height': height,
      'url': url
    };

    return map;
  }

  String toJson(Map json) {
    return jsonEncode(json);
  }

  static Map fromJson(String json) {
    return jsonDecode(json);
  }
}
