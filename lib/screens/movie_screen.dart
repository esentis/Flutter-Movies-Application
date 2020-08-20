import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_api/components/drawer.dart';
import 'package:news_api/constants.dart';
import 'package:news_api/networking/connection.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';

List movie;
Color _heartColor = Colors.white;
bool loaded = false;

class MovieScreen extends StatefulWidget {
  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
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
                          'Article bookmarked',
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
                          'Article removed from bookmarks',
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
                  tag: movie,
                  child: Image.network(
                    movie[1],
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            // Make the initial height of the SliverAppBar larger than normal.
            expandedHeight: 400,
          ),
          // Next, create a SliverList
          SliverList(
            // Use a delegate to build items as they're scrolled on screen.
            delegate: SliverChildBuilderDelegate(
              // The builder function returns a ListTile with a title that
              // displays the index of the current item.
              (context, index) => ListTile(
                  title: ResponsiveBuilder(
                      builder: (context, sizingInformation) => Column(
                            children: [
                              Text(
                                movie[2]['title'],
                                textAlign: TextAlign.center,
                                style: GoogleFonts.newsCycle(
                                  fontSize:
                                      sizingInformation.isMobile ? 25 : 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Divider(
                                thickness: 2,
                                color: Colors.black.withOpacity(0.6),
                              ),
                              const SizedBox(height: 15),
                              Text(movie[2]['plot']),
                            ],
                          ))),
              // Builds 1000 ListTiles
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
