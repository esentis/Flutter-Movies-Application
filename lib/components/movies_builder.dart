import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../constants.dart';
import 'movie_card.dart';

class MoviesBuilder extends StatelessWidget {
  const MoviesBuilder({
    this.scrollController,
    this.itemCount,
    this.sizingInformation,
    this.data,
  });
  final ScrollController scrollController;
  final int itemCount;
  final SizingInformation sizingInformation;
  final dynamic data;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      itemCount: itemCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: getRowCount(sizingInformation),
      ),
      itemBuilder: (BuildContext context, int index) => Hero(
        tag: index,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: MovieCard(
            rating: data['results'][index]['vote_average'].toString(),
            ratingBannerColor: Colors.red.withOpacity(0.5),
            voteCount: data['results'][index]['vote_count'],
            title: data['results'][index]['original_name'] ??
                data['results'][index]['title'],
            date: data['results'][index]['release_date'],
            image: baseImgUrl + data['results'][index]['poster_path'],
            borderColor: const Color(0xFFe0dede).withOpacity(0.5),
            overlayColor: selectedTheme == ThemeSelected.light
                ? const Color(0xFF198FD8).withOpacity(0.7)
                : const Color(0xFF1b262c).withOpacity(0.7),
            textColor: Colors.white,
            elevation: selectedTheme == ThemeSelected.light ? 11 : 10,
            shadowColor: selectedTheme == ThemeSelected.light
                ? Colors.black
                : Colors.white,
            overlayHeight: sizingInformation.isMobile ? 105 : 115,
            onTap: () async {},
          ),
        ),
      ),
    );
  }
}
