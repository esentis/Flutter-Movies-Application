import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_api/networking/connection.dart';
import '../constants.dart';

dynamic movie;

class SearchResults extends StatefulWidget {
  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  @override
  void initState() {
    super.initState();
    movie = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter Movies API',
          style: TextStyle(
            fontSize: 28,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 15,
          ),
          child: ListView.separated(
            itemCount: movie['results'].length,
            itemBuilder: (context, index) => ListTile(
              onTap: () async {
                var movieCredits =
                    await getCredits(movie['results'][index]['id']);
                var movieDetails =
                    await getMovie(movie['results'][index]['id']);
                await Get.toNamed('/movie',
                    arguments:
                        [movieDetails, movieCredits, index, 'search'] ?? '');
              },
              leading: movie['results'][index]['poster_path'] != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.network(
                        '$baseImgUrl${movie['results'][index]['poster_path']}',
                      ),
                    )
                  : Image.asset('assets/images/404_actor.png'),
              title: Text(
                movie['results'][index]['title'],
                style: GoogleFonts.newsCycle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(movie['results'][index]['release_date'],
                  style: GoogleFonts.newsCycle(
                    fontSize: 15,
                  )),
              trailing: Text(
                '${movie['results'][index]['vote_average']}/10',
                style: GoogleFonts.newsCycle(
                  fontSize: 20,
                ),
              ),
            ),
            separatorBuilder: (context, index) => const Divider(),
          ),
        ),
      ),
    );
  }
}
