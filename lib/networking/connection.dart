import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

BaseOptions dioOptions = BaseOptions(
  baseUrl: 'https://newsapi.org/v2/',
  receiveDataWhenStatusError: true,
  connectTimeout: 6 * 1000, // 6 seconds
  receiveTimeout: 6 * 1000, // 6 seconds
);
Dio dio = Dio(dioOptions);

/// Returns headlines from a country using [countryCode].
Future countryHeadlines(String countryCode) async {
  Response response;
  try {
    response = await dio.get(
        'top-headlines?country=$countryCode&apiKey=${DotEnv().env['API_KEY']}');
  } on DioError catch (e) {
    return e.type;
  }
  return response.data;
}

/// Returns articles based on a search [term].
Future searchArcticles(String term) async {
  Response response;
  try {
    response =
        await dio.get('everything?q=$term&apiKey=${DotEnv().env['API_KEY']}');
  } on DioError catch (e) {
    return e.type;
  }
  return response.data;
}
