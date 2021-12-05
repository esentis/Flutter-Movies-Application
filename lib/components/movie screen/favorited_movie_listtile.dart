import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_api/models/movie_detailed.dart';
import 'package:news_api/networking/connection.dart';

import '../../constants.dart';

class FavoriteMovieTile extends StatelessWidget {
  const FavoriteMovieTile({
    required this.movie,
    Key? key,
  }) : super(key: key);
  final MovieDetailed movie;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(60),
        child: Image.network(baseImgUrl + movie.posterPath),
      ),
      title: Text(
        movie.originalTitle ?? (movie.title ?? ''),
        style: GoogleFonts.newsCycle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
      subtitle: Text(
        movie.tagline ?? '',
        style: GoogleFonts.newsCycle(
          color: Colors.white.withOpacity(0.8),
          fontWeight: FontWeight.bold,
          fontSize: 15,
          fontStyle: FontStyle.italic,
        ),
      ),
      onTap: () async {
        var movieDetails = await getMovieDetails(movie.id);
        var movieCredits = await getCredits(movieDetails?.id ?? 0);
        await Get.offAllNamed('/movie',
            arguments: [movieDetails, movieCredits, 'favorites']);
      },
    );
  }
}
