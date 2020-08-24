import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_api/components/drawer.dart';
import 'package:news_api/components/loading.dart';
import 'package:news_api/components/popularity.dart';
import 'package:news_api/constants.dart';
import 'package:responsive_builder/responsive_builder.dart';

List<dynamic> movie;
Color _heartColor = Colors.white;
bool loaded = false;

class MovieScreen extends StatefulWidget {
  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  List<Widget> getGenres(
      List<dynamic> genres, SizingInformation sizingInformation) {
    // ignore: omit_local_variable_types
    List<Widget> genresWidgets = [];
    if (genres.isNotEmpty) {
      for (var genre in genres) {
        genresWidgets.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(genre['name'],
              style: GoogleFonts.newsCycle(
                fontSize: sizingInformation.isMobile ? 15 : 30,
              )),
        ));
      }
    }
    return genresWidgets;
  }

  List<Widget> getCast(List<dynamic> actors) {
    // ignore: omit_local_variable_types
    List<Widget> actorWidgets = [];
    for (var actor in actors) {
      actorWidgets.add(ListTile(
        leading: ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: actor['profile_path'] != null
                ? Image.network('$baseImgUrl${actor['profile_path']}')
                : Image.asset('assets/images/404_actor.png')),
        title: Text(actor['name']),
        subtitle: Text(actor['character']),
      ));
    }
    return actorWidgets;
  }

  @override
  void initState() {
    super.initState();

    movie = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            actions: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (_heartColor == Colors.white) {
                      _heartColor = Colors.red;
                      Get.snackbar(
                        '',
                        '',
                        maxWidth: 350,
                        duration: const Duration(milliseconds: 800),
                        backgroundColor: Colors.green.withOpacity(0.7),
                        borderRadius: 20,
                        borderColor: Colors.white,
                        borderWidth: 5,
                        titleText: Text(
                          'Added to favorites !',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.newsCycle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      );
                      savedMovies.add(movie);
                      logger.i(savedMovies);
                    } else {
                      _heartColor = Colors.white;
                      Get.snackbar(
                        '',
                        '',
                        maxWidth: 350,
                        duration: const Duration(milliseconds: 800),
                        backgroundColor: Colors.red.withOpacity(0.7),
                        borderRadius: 20,
                        borderColor: Colors.white,
                        borderWidth: 5,
                        titleText: Text(
                          'Removed from favorites',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.newsCycle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      );
                      savedMovies.remove(savedMovies.firstWhere(
                          (article) => article['title'] == movie[0]));
                      try {
                        widgetsToDraw.remove(
                          widgetsToDraw.firstWhere(
                            (listTile) => listTile.key == Key(movie[0]),
                          ),
                        );
                      } catch (e) {
                        print(e);
                      }
                      widgetsToDraw.forEach((element) {
                        print(element.key);
                      });
                    }
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF198FD8),
                        Color(0xFFe0dede),
                      ],
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      color: Colors.blue.withOpacity(0.3),
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: _heartColor,
                      size: 60,
                    ),
                  ),
                ),
              ),
            ],
            // Allows the user to reveal the app bar if they begin scrolling
            // back up the list of items.
            floating: true,
            // Display a placeholder widget to visualize the shrinking size.
            flexibleSpace: Stack(
              fit: StackFit.expand,
              children: [
                Hero(
                  tag: movie[0]['id'],
                  child: Image.network(
                    baseImgUrl + movie[0]['poster_path'],
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            // Make the initial height of the SliverAppBar larger than normal.
            expandedHeight: 200,
          ),
          // Next, create a SliverList
          SliverList(
            // Use a delegate to build items as they're scrolled on screen.
            delegate: SliverChildBuilderDelegate(
              // The builder function returns a ListTile with a title that
              // displays the index of the current item.
              (context, index) {
                if (index == 0) {
                  return ListTile(
                    title: ResponsiveBuilder(
                      builder: (context, sizingInformation) => Column(
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        movie[0]['original_title'].length > 30
                                            ? sizingInformation.isMobile
                                                ? '${movie[0]['original_title'].toString().substring(0, 27)}...'
                                                : movie[0]['original_title']
                                            : movie[0]['original_title'],
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.newsCycle(
                                          fontSize: sizingInformation.isMobile
                                              ? 25
                                              : 40,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        movie[0]['tagline'],
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.newsCycle(
                                          fontSize: sizingInformation.isMobile
                                              ? 15
                                              : 25,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        '${movie[0]['vote_average'].toString()}/10',
                                        style: GoogleFonts.newsCycle(
                                          fontSize: sizingInformation.isMobile
                                              ? 25
                                              : 40,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${movie[0]['vote_count']} votes',
                                        style: GoogleFonts.newsCycle(
                                          fontSize: sizingInformation.isMobile
                                              ? 15
                                              : 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Divider(
                                thickness: 2,
                                color: Colors.black.withOpacity(0.6),
                              ),
                              Row(
                                textBaseline: TextBaseline.alphabetic,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'Release date',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.newsCycle(
                                          fontSize: sizingInformation.isMobile
                                              ? 15
                                              : 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        movie[0]['release_date'],
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.newsCycle(
                                          fontSize: sizingInformation.isMobile
                                              ? 15
                                              : 25,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'Duration',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.newsCycle(
                                          fontSize: sizingInformation.isMobile
                                              ? 15
                                              : 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "${movie[0]['runtime'].toString()}'",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.newsCycle(
                                          fontSize: sizingInformation.isMobile
                                              ? 15
                                              : 25,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'Genre',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.newsCycle(
                                          fontSize: sizingInformation.isMobile
                                              ? 15
                                              : 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Column(
                                        children: getGenres(movie[0]['genres'],
                                            sizingInformation),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'Language',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.newsCycle(
                                          fontSize: sizingInformation.isMobile
                                              ? 15
                                              : 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        movie[0]['original_language'],
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.newsCycle(
                                          fontSize: sizingInformation.isMobile
                                              ? 15
                                              : 25,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'Popularity',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.newsCycle(
                                          fontSize: sizingInformation.isMobile
                                              ? 15
                                              : 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      PopularityRating(
                                        centerTextColor:
                                            Colors.black.withOpacity(0.8),
                                        percentage: movie[0]['popularity']
                                            .floor()
                                            .toDouble(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 2,
                            color: Colors.black.withOpacity(0.6),
                          ),
                          Row(
                            children: [],
                          ),
                          const SizedBox(height: 15),
                          Text(
                            movie[0]['overview'],
                            style: GoogleFonts.newsCycle(
                              fontSize: 25,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                if (index == 1) {
                  return ListTile(
                    title: ResponsiveBuilder(
                      builder: (context, sizingInformation) => Column(
                        children: [
                          Divider(
                            thickness: 2,
                            color: Colors.black.withOpacity(0.6),
                          ),
                          Column(
                            children: getCast(movie[1]['cast']),
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                  );
                }
                return const Loading();
              },
              childCount: 2,
            ),
          ),
        ],
      ),
    );
  }
}
