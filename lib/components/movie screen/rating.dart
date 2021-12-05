import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_api/models/movie_detailed.dart';
import 'package:news_api/states/themestate.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Rating extends StatelessWidget {
  const Rating({
    required this.themeState,
    required this.movie,
    required this.sizingInformation,
    Key? key,
  }) : super(key: key);

  final SetThemeState themeState;
  final MovieDetailed movie;
  final SizingInformation sizingInformation;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '${movie.voteAverage.toString()}/10',
          style: GoogleFonts.newsCycle(
            fontSize: sizingInformation.isMobile ? 25 : 40,
            fontWeight: FontWeight.bold,
            color: themeState.selectedTheme == ThemeSelected.light
                ? Colors.black
                : const Color(0xFFf7f7f7),
          ),
        ),
        Text(
          '${movie.voteCount} votes',
          style: GoogleFonts.newsCycle(
            fontSize: sizingInformation.isMobile ? 15 : 30,
            fontWeight: FontWeight.bold,
            color: themeState.selectedTheme == ThemeSelected.light
                ? Colors.black
                : const Color(0xFFf7f7f7),
          ),
        )
      ],
    );
  }
}
