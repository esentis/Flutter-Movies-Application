// To parse this JSON data, do
//
//     final movleResults = movleResultsFromMap(jsonString);

import 'dart:convert';

import 'package:news_api/models/movie.dart';

MovieSearchResults movleResultsFromMap(String str) =>
    MovieSearchResults.fromMap(json.decode(str));

String movleResultsToMap(MovieSearchResults data) => json.encode(data.toMap());

class MovieSearchResults {
  MovieSearchResults({
    this.page,
    this.results,
    this.totalResults,
    this.totalPages,
  });

  int page;
  List<Movie> results;
  int totalResults;
  int totalPages;

  factory MovieSearchResults.fromMap(Map<String, dynamic> json) =>
      MovieSearchResults(
        page: json['page'],
        results: List<Movie>.from(json['results'].map((x) => Movie.fromMap(x))),
        totalResults: json['total_results'],
        totalPages: json['total_pages'],
      );

  Map<String, dynamic> toMap() => {
        'page': page,
        'results': List<dynamic>.from(results.map((x) => x.toMap())),
        'total_results': totalResults,
        'total_pages': totalPages,
      };
}
