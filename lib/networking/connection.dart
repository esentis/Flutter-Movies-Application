import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../constants.dart';

BaseOptions dioTmdbOptions = BaseOptions(
  baseUrl: 'https://api.themoviedb.org',
  receiveDataWhenStatusError: true,
  connectTimeout: 6 * 1000, // 6 seconds
  receiveTimeout: 6 * 1000, // 6 seconds
);
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
    response = await tmdb.get(
        '/3/search/movie?api_key=${DotEnv().env['TMDB_KEY']}&language=en-US&query=$term&page=1&include_adult=false');
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
    response = await tmdb.get('/film/$id');
    logger.i(response.data);
  } on DioError catch (e) {
    logger.e(e);
    return e.type;
  }
  return response.data;
}
