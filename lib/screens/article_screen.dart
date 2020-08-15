import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_api/components/drawer.dart';
import 'package:news_api/constants.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';

Map arguments;
Color _heartColor = Colors.white;

class ArticleSreen extends StatefulWidget {
  @override
  _ArticleSreenState createState() => _ArticleSreenState();
}

class _ArticleSreenState extends State<ArticleSreen> {
  @override
  void initState() {
    super.initState();

    arguments = Get.arguments;
    savedArticles.forEach((element) {
      print(element['key']);
    });
    if (savedArticles.any((article) => article['key'] == arguments['key'])) {
      _heartColor = Colors.red;
    } else {
      _heartColor = Colors.white;
    }
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
                        duration: const Duration(milliseconds: 900),
                        backgroundColor: Colors.green.withOpacity(0.8),
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
                      savedArticles.add(arguments);
                      logger.i(savedArticles);
                    } else {
                      _heartColor = Colors.white;
                      Get.snackbar(
                        '',
                        '',
                        duration: const Duration(milliseconds: 900),
                        backgroundColor: Colors.red.withOpacity(0.8),
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
                      savedArticles.remove(savedArticles.firstWhere(
                          (article) => article['title'] == arguments['title']));
                      try {
                        widgetsToDraw.remove(
                          widgetsToDraw.firstWhere(
                            (listTile) =>
                                listTile.key == Key(arguments['title']),
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
                child: Icon(
                  Icons.favorite,
                  color: _heartColor,
                  size: 60,
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
                  tag: arguments['title'],
                  child: Image.network(
                    arguments['image'],
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
                                arguments['title'],
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
                              Text(
                                arguments['description'],
                                textAlign: TextAlign.center,
                                style: GoogleFonts.newsCycle(
                                  fontSize:
                                      sizingInformation.isMobile ? 25 : 35,
                                ),
                              ),
                              const SizedBox(height: 15),
                              FlatButton(
                                onPressed: () async {
                                  var url = arguments['url'];
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                                child: Text(
                                  '...continue reading',
                                  style: GoogleFonts.newsCycle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        sizingInformation.isMobile ? 25 : 35,
                                  ),
                                ),
                              ),
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
