import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_api/states/themestate.dart';
import 'package:responsive_builder/responsive_builder.dart';

class TitleAndTagline extends StatelessWidget {
  const TitleAndTagline({
    @required this.themeState,
    @required this.sizingInformation,
    @required this.movie,
    Key key,
  }) : super(key: key);

  final SetThemeState themeState;
  final dynamic movie;
  final SizingInformation sizingInformation;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Tooltip(
          message: movie[0]['original_title'],
          textStyle: GoogleFonts.newsCycle(
            fontSize: 20,
            color: Colors.white,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black,
          ),
          child: Hero(
            tag: movie[0]['title'],
            child: Text(
              movie[0]['original_title'].length > 25
                  ? sizingInformation.isMobile
                      ? '${movie[0]['original_title'].toString().substring(0, 15)}...'
                      : sizingInformation
                  : movie[0]['original_title'],
              textAlign: TextAlign.center,
              style: GoogleFonts.newsCycle(
                fontSize: sizingInformation.isMobile ? 20 : 40,
                fontWeight: FontWeight.bold,
                color: themeState.selectedTheme == ThemeSelected.light
                    ? Colors.black
                    : const Color(0xFFf7f7f7),
              ),
            ),
          ),
        ),
        Tooltip(
          message: movie[0]['tagline'],
          textStyle: GoogleFonts.newsCycle(
            fontSize: 20,
            color: Colors.white,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black,
          ),
          child: Text(
            movie[0]['tagline'].length > 40
                ? '${movie[0]['tagline'].toString().substring(0, 40)}...'
                : movie[0]['tagline'],
            textAlign: TextAlign.center,
            style: GoogleFonts.newsCycle(
              fontSize: sizingInformation.isMobile
                  ? 15
                  : sizingInformation.isTablet ? 20 : 25,
              color: themeState.selectedTheme == ThemeSelected.light
                  ? Colors.black
                  : const Color(0xFFf7f7f7),
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }
}
