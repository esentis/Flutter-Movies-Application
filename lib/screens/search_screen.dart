import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_api/components/movie_card.dart';
import 'package:news_api/networking/connection.dart';
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
    logger.w(arguments['titles'].length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter News API',
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
                itemCount: arguments['titles'].length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: getRowCount(sizingInformation),
                ),
                itemBuilder: (BuildContext context, int index) => Hero(
                  tag: index,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: MovieCard(
                      title: arguments['titles'][index]['title'],
                      date: arguments['titles'][index]['date'] ?? 'no date',
                      image: arguments['titles'][index]['image'],
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
                      onTap: () async {
                        var movie =
                            await getMovie(arguments['titles'][index]['id']);
                        await Get.toNamed(
                          '/movie',
                          arguments: [
                            arguments['titles'][index]['id'],
                            arguments['titles'][index]['image'],
                            movie,
                          ],
                        );
                      },
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
