import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_api/components/general/popularity.dart';
import 'package:news_api/states/themestate.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Popularity extends StatelessWidget {
  const Popularity({
    @required this.themeState,
    @required this.movie,
    @required this.sizingInformation,
    Key key,
  })  : assert(
          themeState != null && movie != null && sizingInformation != null,
          'Required fields are missing',
        ),
        super(key: key);

  final SetThemeState themeState;
  final SizingInformation sizingInformation;
  final dynamic movie;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Popularity',
          textAlign: TextAlign.center,
          style: GoogleFonts.newsCycle(
            fontSize: sizingInformation.isMobile
                ? 15
                : sizingInformation.isTablet
                    ? 20
                    : 25,
            fontWeight: FontWeight.bold,
            color: themeState.selectedTheme == ThemeSelected.light
                ? Colors.black
                : const Color(0xFFf7f7f7),
          ),
        ),
        PopularityRating(
          fontSize: 15,
          radius: 60,
          centerTextColor: themeState.selectedTheme == ThemeSelected.light
              ? Colors.black
              : const Color(0xFFf7f7f7),
          percentage: movie[0].popularity.floor().toDouble(),
        ),
      ],
    );
  }
}
