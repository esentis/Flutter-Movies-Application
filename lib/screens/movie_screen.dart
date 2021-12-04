import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_api/components/general/drawer.dart';
import 'package:news_api/components/general/loading.dart';
import 'package:news_api/components/general/snackbar.dart';
import 'package:news_api/components/movie%20screen/favorited_movie_listtile.dart';
import 'package:news_api/components/movie%20screen/genres.dart';
import 'package:news_api/components/movie%20screen/heart_icon.dart';
import 'package:news_api/components/movie%20screen/movie_duration.dart';
import 'package:news_api/components/movie%20screen/movie_language.dart';
import 'package:news_api/components/movie%20screen/popularity_information.dart';
import 'package:news_api/components/movie%20screen/rating.dart';
import 'package:news_api/components/movie%20screen/release_date.dart';
import 'package:news_api/components/movie%20screen/title_and_tagline.dart';
import 'package:news_api/constants.dart';
import 'package:news_api/screens/main_screen.dart';
import 'package:news_api/states/themestate.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

List<dynamic>? movie;
Color? _heartColor;
bool loaded = false;

class MovieScreen extends StatefulWidget {
  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  List<Widget> getCast(List<dynamic> actors,
      SizingInformation sizingInformation, SetThemeState themeState) {
    // ignore: omit_local_variable_types
    List<Widget> actorWidgets = [];
    for (var actor in actors) {
      logger.wtf(actor.profilePath);
      actorWidgets.add(ListTile(
        leading: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: actor.profilePath != null && actor.profilePath.isNotEmpty
                ? Image.network('$baseImgUrl${actor.profilePath}')
                : Image.asset('assets/images/404_actor.png')),
        title: Text(
          actor.name,
          style: GoogleFonts.newsCycle(
            fontSize: sizingInformation.isDesktop ? 35 : 20,
            color: themeState.selectedTheme == ThemeSelected.light
                ? Colors.black
                : const Color(0xFFf7f7f7),
          ),
        ),
        subtitle: Text(
          actor.character,
          style: GoogleFonts.newsCycle(
            fontSize: sizingInformation.isDesktop ? 25 : 15,
            color: themeState.selectedTheme == ThemeSelected.light
                ? Colors.black
                : const Color(0xFFf7f7f7),
          ),
        ),
      ));
    }
    return actorWidgets;
  }

  @override
  void initState() {
    super.initState();
    movie = Get.arguments;
    if (savedMovies.isNotEmpty) {
      if (savedMovies.any((element) => element['id'] == movie![0].id)) {
        _heartColor = Colors.red;
      } else {
        _heartColor = Colors.white;
      }
    } else {
      _heartColor = Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    var themeState = context.watch<SetThemeState>();
    return Theme(
      data: ThemeData(
        canvasColor: themeState.selectedTheme == ThemeSelected.dark
            ? const Color(0xff1a1a2e)
            : const Color(0xFFf7f7f7),
      ),
      child: Scaffold(
        body: ResponsiveBuilder(
          builder: (context, sizingInformation) => CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                elevation: 20,
                title: Hero(
                  tag: 'MOVIESLOGO',
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      scale: 5.5,
                    ),
                  ),
                ),
                shadowColor: Colors.black,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(60),
                    bottomLeft: Radius.circular(60),
                  ),
                ),
                leading: GestureDetector(
                  onTap: () {
                    if (movie![3] == 'favorites') {
                      Get.to(MainScreen());
                    } else {
                      Get.back();
                    }
                  },
                  child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      radius: 20,
                      child: Icon(
                        Icons.arrow_back,
                        size: 40,
                      )),
                ),
                actions: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_heartColor == Colors.white) {
                          _heartColor = Colors.red;
                          buildSnackbar(
                            sizingInformation: sizingInformation,
                            fontSize: 35,
                            titleText: 'Added to favorites !',
                            backgroundColor: Colors.green.withOpacity(0.7),
                            borderColor: Colors.white,
                          );
                          savedMovies.add(movie![0]);
                          widgetsToDraw.add(
                            FavoriteMovieTile(
                              movie: movie,
                              key: Key(movie![0].id.toString()),
                            ),
                          );
                        } else {
                          _heartColor = Colors.white;
                          buildSnackbar(
                            sizingInformation: sizingInformation,
                            borderColor: Colors.white,
                            backgroundColor: Colors.red.withOpacity(0.7),
                            fontSize: 35,
                            titleText: 'Removed from favorites',
                          );
                          savedMovies.remove(
                            savedMovies.firstWhere(
                                (element) => element['id'] == movie![0].id),
                          );

                          try {
                            widgetsToDraw.remove(
                              widgetsToDraw.firstWhere(
                                (listTile) =>
                                    listTile.key == Key(movie![0].id.toString()),
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
                    child: HeartIcon(heartColor: _heartColor!),
                  ),
                ],
                // Allows the user to reveal the app bar if they begin scrolling
                // back up the list of items.
                floating: true,
                // Display a placeholder widget to visualize the shrinking size.
                flexibleSpace: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      baseImgUrl + movie![0].posterPath,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                // Make the initial height of the SliverAppBar larger than normal.
                expandedHeight: sizingInformation.isDesktop ? 500 : 200,
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
                                      Flexible(
                                        child: TitleAndTagline(
                                          themeState: themeState,
                                          sizingInformation: sizingInformation,
                                          movie: movie,
                                        ),
                                      ),
                                      Flexible(
                                        child: Rating(
                                          themeState: themeState,
                                          movie: movie,
                                          sizingInformation: sizingInformation,
                                        ),
                                      )
                                    ],
                                  ),
                                  Divider(
                                    thickness: 2,
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                                  Row(
                                    textBaseline: TextBaseline.alphabetic,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ReleaseDate(
                                        themeState: themeState,
                                        sizingInformation: sizingInformation,
                                        movie: movie,
                                      ),
                                      MovieDuration(
                                        themeState: themeState,
                                        sizingInformation: sizingInformation,
                                        movie: movie,
                                      ),
                                      Genres(
                                        themeState: themeState,
                                        sizingInformation: sizingInformation,
                                        movie: movie,
                                      ),
                                      Language(
                                        themeState: themeState,
                                        sizingInformation: sizingInformation,
                                        movie: movie,
                                      ),
                                      Popularity(
                                        themeState: themeState,
                                        sizingInformation: sizingInformation,
                                        movie: movie,
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
                                movie![0].overview,
                                style: GoogleFonts.newsCycle(
                                  fontSize:
                                      sizingInformation.isDesktop ? 35 : 25,
                                  letterSpacing: 0.2,
                                  color: themeState.selectedTheme ==
                                          ThemeSelected.light
                                      ? Colors.black
                                      : const Color(0xFFf7f7f7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    if (index == 1) {
                      return ListTile(
                        title: Column(
                          children: [
                            Divider(
                              thickness: 2,
                              color: Colors.black.withOpacity(0.6),
                            ),
                            Column(
                              children: getCast(
                                  movie![1].cast, sizingInformation, themeState),
                            ),
                            const SizedBox(height: 15),
                          ],
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
        ),
      ),
    );
  }
}
