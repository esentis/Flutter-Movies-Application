// To parse this JSON data, do
//
//     final movieCredits = movieCreditsFromMap(jsonString);

import 'dart:convert';
import 'package:news_api/models/cast.dart';

MovieCredits movieCreditsFromMap(String str) =>
    MovieCredits.fromMap(json.decode(str));

String movieCreditsToMap(MovieCredits data) => json.encode(data.toMap());

class MovieCredits {
  MovieCredits({
    this.id,
    this.cast,
    this.crew,
  });

  int id;
  List<Cast> cast;
  List<Cast> crew;

  factory MovieCredits.fromMap(Map<String, dynamic> json) => MovieCredits(
        id: json['id'],
        cast: List<Cast>.from(json['cast'].map((x) => Cast.fromMap(x))),
        crew: List<Cast>.from(json['crew'].map((x) => Cast.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'cast': List<dynamic>.from(cast.map((x) => x.toMap())),
        'crew': List<dynamic>.from(crew.map((x) => x.toMap())),
      };
}
