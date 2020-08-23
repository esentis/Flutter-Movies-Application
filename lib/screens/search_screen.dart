import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_api/components/movie_card.dart';
import 'package:news_api/states/themestate.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../constants.dart';

dynamic arguments;
ScrollController _scrollController;

class SearchResults extends StatefulWidget {
  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  @override
  void initState() {
    super.initState();
    arguments = Get.arguments;
    logger.w(arguments['results'].length);
    logger.w(arguments['results'][0]['release_date']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter Movies API',
          style: TextStyle(
            fontSize: 28,
          ),
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Searching for ',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
          Expanded(
            child: ResponsiveBuilder(
              builder: (context, sizingInformation) => GridView.builder(
                controller: _scrollController,
                itemCount: arguments['results'].length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: getRowCount(sizingInformation),
                ),
                itemBuilder: (BuildContext context, int index) => Hero(
                  tag: index,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: MovieCard(
                      rating: arguments['results'][index]['vote_average']
                              .toString() ??
                          'No votes',
                      percentage:
                          (arguments['results'][index]['popularity']).floor() ??
                              0,
                      ratingBannerColor: Colors.red.withOpacity(0.5),
                      voteCount: arguments['results'][index]['vote_count'] ??
                          'No votes',
                      title: arguments['results'][index]['original_name'] ??
                          arguments['results'][index]['title'],
                      date: arguments['results'][index]['release_date'] ??
                          'No release date',
                      image: arguments['results'][index]['poster_path'] == null
                          ? 'assets/images/404.png'
                          : baseImgUrl +
                              arguments['results'][index]['poster_path'],
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
                      onTap: () async {},
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
