import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_api/models/movie_detailed.dart';
import 'package:news_api/states/themestate.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Genres extends StatelessWidget {
  const Genres({
    required this.themeState,
    required this.sizingInformation,
    required this.movie,
    Key? key,
  }) : super(key: key);

  final SetThemeState themeState;
  final SizingInformation sizingInformation;
  final MovieDetailed movie;
  List<Widget> getGenres(List<dynamic> genres,
      SizingInformation sizingInformation, SetThemeState themeState) {
    // ignore: omit_local_variable_types
    List<Widget> genresWidgets = [];
    if (genres.isNotEmpty) {
      for (var genre in genres) {
        genresWidgets.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(genre.name,
              style: GoogleFonts.newsCycle(
                fontSize: sizingInformation.isMobile ? 15 : 30,
                color: themeState.selectedTheme == ThemeSelected.light
                    ? Colors.black
                    : const Color(0xFFf7f7f7),
              )),
        ));
      }
    }
    return genresWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Genre',
          textAlign: TextAlign.center,
          style: GoogleFonts.newsCycle(
            fontSize: sizingInformation.isMobile ? 15 : 25,
            fontWeight: FontWeight.bold,
            color: themeState.selectedTheme == ThemeSelected.light
                ? Colors.black
                : const Color(0xFFf7f7f7),
          ),
        ),
        Column(
          children: getGenres(
            movie.genres ?? [],
            sizingInformation,
            themeState,
          ),
        ),
      ],
    );
  }
}

List<Widget> getGenres(List<int>? genres, SizingInformation sizingInformation) {
  // ignore: omit_local_variable_types
  List<Widget> genresWidgets = [];
  if (genres?.isNotEmpty ?? false) {
    for (var genre in genres!) {
      switch (genre) {
        case 28:
          genresWidgets.add(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text('Action',
                style: GoogleFonts.newsCycle(
                  fontSize: sizingInformation.isMobile ? 13 : 15,
                  color: Colors.white,
                )),
          ));
          break;
        case 12:
          genresWidgets.add(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text('Adventure',
                style: GoogleFonts.newsCycle(
                  fontSize: sizingInformation.isMobile ? 13 : 15,
                  color: Colors.white,
                )),
          ));
          break;
        case 16:
          genresWidgets.add(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text('Animation',
                style: GoogleFonts.newsCycle(
                  fontSize: sizingInformation.isMobile ? 13 : 15,
                  color: Colors.white,
                )),
          ));
          break;
        case 35:
          genresWidgets.add(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text('Comedy',
                style: GoogleFonts.newsCycle(
                  fontSize: sizingInformation.isMobile ? 13 : 15,
                  color: Colors.white,
                )),
          ));
          break;
        case 80:
          genresWidgets.add(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text('Crime',
                style: GoogleFonts.newsCycle(
                  fontSize: sizingInformation.isMobile ? 13 : 15,
                  color: Colors.white,
                )),
          ));
          break;
        case 99:
          genresWidgets.add(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text('Documentary',
                style: GoogleFonts.newsCycle(
                  fontSize: sizingInformation.isMobile ? 13 : 15,
                  color: Colors.white,
                )),
          ));
          break;
        case 18:
          genresWidgets.add(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text('Drama',
                style: GoogleFonts.newsCycle(
                  fontSize: sizingInformation.isMobile ? 13 : 15,
                  color: Colors.white,
                )),
          ));
          break;
        case 10751:
          genresWidgets.add(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text('Family',
                style: GoogleFonts.newsCycle(
                  fontSize: sizingInformation.isMobile ? 13 : 15,
                  color: Colors.white,
                )),
          ));
          break;
        case 14:
          genresWidgets.add(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text('Fantasy',
                style: GoogleFonts.newsCycle(
                  fontSize: sizingInformation.isMobile ? 13 : 15,
                  color: Colors.white,
                )),
          ));
          break;
        case 36:
          genresWidgets.add(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text('History',
                style: GoogleFonts.newsCycle(
                  fontSize: sizingInformation.isMobile ? 13 : 15,
                  color: Colors.white,
                )),
          ));
          break;
        case 27:
          genresWidgets.add(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text('Horror',
                style: GoogleFonts.newsCycle(
                  fontSize: sizingInformation.isMobile ? 13 : 15,
                  color: Colors.white,
                )),
          ));
          break;
        case 10402:
          genresWidgets.add(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text('Music',
                style: GoogleFonts.newsCycle(
                  fontSize: sizingInformation.isMobile ? 13 : 15,
                  color: Colors.white,
                )),
          ));
          break;
        case 9648:
          genresWidgets.add(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text('Mystery',
                style: GoogleFonts.newsCycle(
                  fontSize: sizingInformation.isMobile ? 13 : 15,
                  color: Colors.white,
                )),
          ));
          break;
        case 10749:
          genresWidgets.add(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text('Romance',
                style: GoogleFonts.newsCycle(
                  fontSize: sizingInformation.isMobile ? 13 : 15,
                  color: Colors.white,
                )),
          ));
          break;
        case 878:
          genresWidgets.add(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text('Sci-Fi',
                style: GoogleFonts.newsCycle(
                  fontSize: sizingInformation.isMobile ? 13 : 15,
                  color: Colors.white,
                )),
          ));
          break;
        case 10770:
          genresWidgets.add(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text('TV-Movie',
                style: GoogleFonts.newsCycle(
                  fontSize: sizingInformation.isMobile ? 13 : 15,
                  color: Colors.white,
                )),
          ));
          break;
        case 53:
          genresWidgets.add(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text('Thriller',
                style: GoogleFonts.newsCycle(
                  fontSize: sizingInformation.isMobile ? 13 : 15,
                  color: Colors.white,
                )),
          ));
          break;
        case 10752:
          genresWidgets.add(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text('War',
                style: GoogleFonts.newsCycle(
                  fontSize: sizingInformation.isMobile ? 13 : 15,
                  color: Colors.white,
                )),
          ));
          break;
        case 37:
          genresWidgets.add(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text('Western',
                style: GoogleFonts.newsCycle(
                  fontSize: sizingInformation.isMobile ? 13 : 15,
                  color: Colors.white,
                )),
          ));
          break;
        default:
          genresWidgets.add(const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: SizedBox(),
          ));
          break;
      }
    }
  }
  return genresWidgets;
}
