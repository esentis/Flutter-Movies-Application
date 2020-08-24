import 'package:flutter/material.dart';
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
  });
  final ScrollController scrollController;
  final int itemCount;
  final SizingInformation sizingInformation;
  final dynamic data;
  final Color progressColor;
  final String widgetOrigin;

  @override
  Widget build(BuildContext context) {
    var loader = context.watch<SetLoading>();
    return GridView.builder(
      controller: scrollController,
      scrollDirection: Axis.horizontal,
      itemCount: itemCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: getRowCount(sizingInformation),
      ),
      itemBuilder: (BuildContext context, int index) => Padding(
        padding: const EdgeInsets.all(12.0),
        child: Hero(
          tag: widgetOrigin == 'Upcoming movies'
              ? '${data['results'][index]['id']}+UpcomingMovies'
              : '${data['results'][index]['id']}+LatestMovies',
          child: MovieCard(
            rating: data['results'][index]['vote_average'].toString(),
            percentage:
                (data['results'][index]['popularity']).floor().toDouble(),
            ratingBannerColor: Colors.red.withOpacity(0.5),
            voteCount: data['results'][index]['vote_count'],
            title: data['results'][index]['original_name'] ??
                data['results'][index]['title'],
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
