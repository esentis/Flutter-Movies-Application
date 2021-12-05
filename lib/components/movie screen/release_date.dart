import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_api/models/movie_detailed.dart';
import 'package:news_api/states/themestate.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ReleaseDate extends StatelessWidget {
  const ReleaseDate({
    required this.themeState,
    required this.movie,
    required this.sizingInformation,
    Key? key,
  }) : super(key: key);

  final SetThemeState themeState;
  final SizingInformation sizingInformation;
  final MovieDetailed movie;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Release date',
          textAlign: TextAlign.center,
          style: GoogleFonts.newsCycle(
            fontSize: sizingInformation.isMobile ? 15 : 25,
            fontWeight: FontWeight.bold,
            color: themeState.selectedTheme == ThemeSelected.light
                ? Colors.black
                : const Color(0xFFf7f7f7),
          ),
        ),
        if (movie.releaseDate != null)
          Text(
            formatDate(movie.releaseDate!, [d, '-', M, '-', yy]),
            textAlign: TextAlign.center,
            style: GoogleFonts.newsCycle(
              fontSize: sizingInformation.isMobile ? 15 : 25,
              color: themeState.selectedTheme == ThemeSelected.light
                  ? Colors.black
                  : const Color(0xFFf7f7f7),
            ),
          ),
      ],
    );
  }
}
