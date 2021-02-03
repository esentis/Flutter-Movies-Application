// To parse this JSON data, do
//
//     final movie = movieFromMap(jsonString);

import 'dart:convert';

Movie movieFromMap(String str) => Movie.fromMap(json.decode(str));

String movieToMap(Movie data) => json.encode(data.toMap());

class Movie {
  Movie({
    this.posterPath,
    this.adult,
    this.overview,
    this.releaseDate,
    this.genreIds,
    this.id,
    this.originalTitle,
    this.originalLanguage,
    this.title,
    this.backdropPath,
    this.popularity,
    this.voteCount,
    this.video,
    this.voteAverage,
  });

  String posterPath;
  bool adult;
  String overview;
  DateTime releaseDate;
  List<int> genreIds;
  int id;
  String originalTitle;
  String originalLanguage;
  String title;
  String backdropPath;
  double popularity;
  int voteCount;
  bool video;
  double voteAverage;

  factory Movie.fromMap(Map<String, dynamic> json) => Movie(
        posterPath: json['poster_path'],
        adult: json['adult'],
        overview: json['overview'],
        releaseDate: DateTime.parse(json['release_date']),
        genreIds: List<int>.from(json['genre_ids'].map((x) => x)),
        id: json['id'],
        originalTitle: json['original_title'],
        originalLanguage: json['original_language'],
        title: json['title'],
        backdropPath: json['backdrop_path'],
        popularity: json['popularity'].toDouble(),
        voteCount: json['vote_count'],
        video: json['video'],
        voteAverage: json['vote_average'].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        'poster_path': posterPath,
        'adult': adult,
        'overview': overview,
        'release_date':
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        'genre_ids': List<dynamic>.from(genreIds.map((x) => x)),
        'id': id,
        'original_title': originalTitle,
        'original_language': originalLanguage,
        'title': title,
        'backdrop_path': backdropPath,
        'popularity': popularity,
        'vote_count': voteCount,
        'video': video,
        'vote_average': voteAverage,
      };
}
