import 'package:logger/logger.dart';

List<String> favArticlesTitles = [];
List<Map> savedArticles = [];
var logger = Logger();

/// Maps the article information
extension Mapping on List<dynamic> {
  Map toMap(int index) {
    return {
      'title': this[0]['articles'][index]['title'],
      'author': this[0]['articles'][index]['author'],
      'image': this[0]['articles'][index]['urlToImage'],
      'url': this[0]['articles'][index]['url'],
      'key': this[0]['articles'][index]['title'],
      'description': this[0]['articles'][index]['description'],
    };
  }
}
