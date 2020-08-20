import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_api/networking/connection.dart';

class SearchResults extends StatefulWidget {
  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  Future fetchArticles(String term) async {
    var articles = await searchMovies(term);
    return articles;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter News API',
          style: TextStyle(
            fontSize: 28,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Searching for ${Get.arguments}',
              style: const TextStyle(
                fontSize: 30,
              ),
            ),
          ),
          FutureBuilder(
              future: fetchArticles(Get.arguments),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: data['articles'].length,
                      itemBuilder: (BuildContext context, int index) =>
                          ListTile(
                        title: Text(data['articles'][index]['title']) ??
                            const Text('No title found'),
                        subtitle: Text(data['articles'][index]['author'] ??
                            'No author found'),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(180),
                          child: Image(
                              image: NetworkImage(data['articles'][index]
                                      ['urlToImage'] ??
                                  'No image found')),
                        ),
                      ),
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 10,
                  ),
                );
              }),
        ],
      ),
    );
  }
}
