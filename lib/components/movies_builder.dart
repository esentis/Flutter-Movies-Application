import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:news_api/networking/connection.dart';
import 'package:news_api/states/loadingstate.dart';
import 'package:news_api/states/themestate.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../constants.dart';
import 'movie_card.dart';
import 'package:provider/provider.dart';

class MoviesBuilder extends StatelessWidget {
  const MoviesBuilder({
    this.scrollController,
    this.itemCount,
    this.sizingInformation,
    this.data,
    this.progressColor,
    this.widgetOrigin,
    this.scrollDirection,
    this.rowCount,
  });
  final ScrollController scrollController;
  final int itemCount;
  final SizingInformation sizingInformation;
  final dynamic data;
  final Color progressColor;
  final String widgetOrigin;
  final Axis scrollDirection;
  final int rowCount;

  @override
  Widget build(BuildContext context) {
    var loader = context.watch<SetLoading>();
    return GridView.builder(
      controller: scrollController,
      scrollDirection: scrollDirection,
      itemCount: itemCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: rowCount,
      ),
      itemBuilder: (BuildContext context, int index) => Padding(
        padding: const EdgeInsets.all(12.0),
        child: Hero(
          tag: '${data['results'][index]['id']}+$widgetOrigin',
          child: MovieCard(
            rating: '${data['results'][index]['vote_average'].toString()}/10',
            percentage:
                (data['results'][index]['popularity']).floor().toDouble(),
            ratingBannerColor: Colors.red.withOpacity(0.5),
            voteCount: data['results'][index]['vote_count'],
            title: data['results'][index]['original_name'] != null
                ? data['results'][index]['original_name'].length > 10
                    ? data['results'][index]['original_name']
                        .toString()
                        .substring(0, 10)
                    : data['results'][index]['original_name']
                : data['results'][index]['title'].length > 10
                    ? data['results'][index]['title']
                        .toString()
                        .substring(0, 10)
                    : data['results'][index]['title'],
            date: data['results'][index]['release_date'],
            image: baseImgUrl + data['results'][index]['poster_path'],
            borderColor: const Color(0xFFe0dede).withOpacity(0.5),
            overlayColor: selectedTheme == ThemeSelected.light
                ? const Color(0xFF198FD8).withOpacity(0.7)
                : const Color(0xFF1b262c).withOpacity(0.93),
            textColor: Colors.white,
            elevation: selectedTheme == ThemeSelected.light ? 11 : 10,
            shadowColor: selectedTheme == ThemeSelected.light
                ? Colors.black
                : Colors.white,
            overlayHeight: sizingInformation.isMobile ? 105 : 115,
            onTap: () async {
              loader.toggleLoading();
              logger.i(
                  'Searching for movie with ID : ${data['results'][index]['id']}');
              var movieDetails = await getMovie(data['results'][index]['id']);
              var movieCredits = await getCredits(movieDetails['id']);
              loader.toggleLoading();
              await Get.toNamed('/movie',
                  arguments:
                      [movieDetails, movieCredits, index, widgetOrigin] ?? '');
            },
          ),
        ),
      ),
    );
  }
}
