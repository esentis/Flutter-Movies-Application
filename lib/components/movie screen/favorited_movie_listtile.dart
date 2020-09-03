import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_api/networking/connection.dart';

import '../../constants.dart';

class FavoriteMovieTile extends StatelessWidget {
  const FavoriteMovieTile({
    @required this.movie,
    Key key,
  })  : assert(
          movie != null,
          'Required field is missing',
        ),
        super(key: key);
  final dynamic movie;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(60),
        child: Image.network(baseImgUrl + movie[0]['poster_path']),
      ),
      title: Text(
        movie[0]['original_title'] ?? movie[0]['title'],
        style: GoogleFonts.newsCycle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
      subtitle: Text(
        movie[0]['tagline'] ?? '',
        style: GoogleFonts.newsCycle(
          color: Colors.white.withOpacity(0.8),
          fontWeight: FontWeight.bold,
          fontSize: 15,
          fontStyle: FontStyle.italic,
        ),
      ),
      onTap: () async {
        var movieDetails = await getMovie(movie[0]['id']);
        var movieCredits = await getCredits(movieDetails['id']);
        await Get.offAllNamed('/movie',
            arguments: [movieDetails, movieCredits, 0, 'favorites'] ?? '');
      },
    );
  }
}
