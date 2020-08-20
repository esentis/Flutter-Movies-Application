import 'package:logger/logger.dart';

List<String> favMovieTitles = [];
List savedMovies = [];
var logger = Logger();

/// Maps the article information
extension Mapping on List<dynamic> {
  Map toMap(int index) {
    return {
      'title': this[0]['titles'][index]['title'],
      'author': this[0]['articles'][index]['author'],
      'image': this[0]['articles'][index]['image'],
      'key': this[0]['titles'][index]['id'],
      'description': this[0]['articles'][index]['description'],
    };
  }
}
