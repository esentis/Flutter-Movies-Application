import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_api/states/themestate.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Language extends StatelessWidget {
  const Language({
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
          'Language',
          textAlign: TextAlign.center,
          style: GoogleFonts.newsCycle(
            fontSize: sizingInformation.isMobile ? 15 : 25,
            fontWeight: FontWeight.bold,
            color: themeState.selectedTheme == ThemeSelected.light
                ? Colors.black
                : const Color(0xFFf7f7f7),
          ),
        ),
        Text(
          movie[0]['original_language'],
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
