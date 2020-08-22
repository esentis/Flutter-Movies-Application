import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../constants.dart';

BaseOptions dioImdbOptions = BaseOptions(
    baseUrl: 'https://imdb-internet-movie-database-unofficial.p.rapidapi.com',
    receiveDataWhenStatusError: true,
    connectTimeout: 6 * 1000, // 6 seconds
    receiveTimeout: 6 * 1000, // 6 seconds
    headers: {
      'x-rapidapi-host':
          'imdb-internet-movie-database-unofficial.p.rapidapi.com',
      'x-rapidapi-key': DotEnv().env['API_KEY'],
      'useQueryString': true
    });
BaseOptions dioTmdbOptions = BaseOptions(
  baseUrl: 'https://api.themoviedb.org',
  receiveDataWhenStatusError: true,
  connectTimeout: 6 * 1000, // 6 seconds
  receiveTimeout: 6 * 1000, // 6 seconds
);
Dio imdb = Dio(dioImdbOptions);
Dio tmdb = Dio(dioTmdbOptions);

/// Returns movies based on a search [term].
Future getTrending() async {
  Response response;
  try {
    response = await tmdb
        .get('/3/trending/movie/day?api_key=${DotEnv().env['TMDB_KEY']}');
    logger.i(response.data);
  } on DioError catch (e) {
    logger.e(e);
    return e.type;
  }
  return response.data;
}

/// Returns movies based on a search [term].
Future searchMovies(String term) async {
  Response response;
  try {
    response = await imdb.get('/search/$term');
    logger.i(response.data);
  } on DioError catch (e) {
    logger.e(e);
    return e.type;
  }
  return response.data;
}

/// Returns movies based on [id].
Future getMovie(String id) async {
  Response response;
  try {
    response = await imdb.get('/film/$id');
    logger.i(response.data);
  } on DioError catch (e) {
    logger.e(e);
    return e.type;
  }
  return response.data;
}
