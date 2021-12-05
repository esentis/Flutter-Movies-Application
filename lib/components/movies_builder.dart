import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_api/models/movie.dart';
import 'package:news_api/networking/connection.dart';
import 'package:news_api/states/loadingstate.dart';
import 'package:news_api/states/themestate.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../constants.dart';
import 'movie screen/genres.dart';
import 'movie_card.dart';

class MoviesBuilder extends StatelessWidget {
  const MoviesBuilder({
    required this.scrollController,
    required this.itemCount,
    required this.sizingInformation,
    required this.movies,
    required this.widgetOrigin,
    required this.scrollDirection,
    required this.rowCount,
    this.progressColor,
    this.onRefresh,
    this.refreshController,
  });
  final ScrollController scrollController;
  final int itemCount;
  final SizingInformation sizingInformation;
  final List<Movie>? movies;
  final Color? progressColor;
  final String widgetOrigin;
  final Axis scrollDirection;
  final int rowCount;
  final Function? onRefresh;
  final RefreshController? refreshController;

  @override
  Widget build(BuildContext context) {
    var loader = context.watch<SetLoading>();
    var themeState = context.watch<SetThemeState>();
    return sizingInformation.isMobile || sizingInformation.isTablet
        ? SmartRefresher(
            controller: refreshController!,
            onRefresh: onRefresh as void Function()?,
            header: WaterDropMaterialHeader(
              distance: 120,
              color: themeState.selectedTheme == ThemeSelected.dark
                  ? const Color(0xFFEC1E79)
                  : const Color(0xff16213e),
              backgroundColor: themeState.selectedTheme == ThemeSelected.dark
                  ? const Color(0xff16213e)
                  : const Color(0xFF198FD8),
              offset: 5,
            ),
            child: GridView.builder(
              controller: scrollController,
              scrollDirection: scrollDirection,
              itemCount: itemCount,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: rowCount,
              ),
              itemBuilder: (BuildContext context, int index) => Padding(
                padding: const EdgeInsets.all(12.0),
                child: Hero(
                  tag: '${movies![index].id}+$widgetOrigin',
                  child: MovieCard(
                    rating: '${movies![index].voteAverage.toString()}/10',
                    genres: getGenres(
                                    movies![index].genreIds!, sizingInformation)
                                .length >
                            2
                        ? getGenres(movies![index].genreIds!, sizingInformation)
                            .sublist(0, 2)
                        : getGenres(
                            movies![index].genreIds!, sizingInformation),
                    percentage: movies![index].popularity!.floor().toDouble(),
                    ratingBannerColor: Colors.red.withOpacity(0.5),
                    voteCount: movies![index].voteCount,
                    title: movies![index].originalTitle != null
                        ? movies![index].originalTitle!.length > 10
                            ? movies![index]
                                .originalTitle
                                .toString()
                                .substring(0, 10)
                            : movies![index].originalTitle
                        : movies![index].originalTitle,
                    date: movies![index].releaseDate.toString(),
                    image: baseImgUrl + movies![index].posterPath!,
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
                      var movieDetails =
                          await getMovieDetails(movies![index].id ?? 0);
                      var movieCredits =
                          await getCredits(movieDetails?.id ?? 0);
                      loader.toggleLoading();
                      await Get.toNamed('/movie', arguments: [
                        movieDetails,
                        movieCredits,
                        widgetOrigin
                      ]);
                    },
                  ),
                ),
              ),
            ),
          )
        : GridView.builder(
            controller: scrollController,
            scrollDirection: scrollDirection,
            itemCount: itemCount,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: rowCount,
            ),
            itemBuilder: (BuildContext context, int index) => Padding(
              padding: const EdgeInsets.all(12.0),
              child: Hero(
                tag: '${movies![index].id}+$widgetOrigin',
                child: MovieCard(
                  rating: '${movies![index].voteAverage.toString()}/10',
                  genres: getGenres(movies![index].genreIds!, sizingInformation)
                              .length >
                          2
                      ? getGenres(movies![index].genreIds!, sizingInformation)
                          .sublist(0, 2)
                      : getGenres(movies![index].genreIds!, sizingInformation),
                  percentage: movies![index].popularity!.floor().toDouble(),
                  ratingBannerColor: Colors.red.withOpacity(0.5),
                  voteCount: movies![index].voteCount,
                  title: movies![index].originalTitle != null
                      ? movies![index].originalTitle!.length > 10
                          ? movies![index]
                              .originalTitle
                              .toString()
                              .substring(0, 10)
                          : movies![index].originalTitle
                      : movies![index].originalTitle,
                  date: movies![index].releaseDate.toString(),
                  image: baseImgUrl + movies![index].posterPath!,
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
                    var movieDetails =
                        await getMovieDetails(movies![index].id ?? 0);
                    var movieCredits = await getCredits(movieDetails?.id ?? 0);
                    loader.toggleLoading();
                    await Get.toNamed('/movie', arguments: [
                      movieDetails,
                      movieCredits,
                      widgetOrigin,
                    ]);
                  },
                ),
              ),
            ),
          );
  }
}
