import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_api/constants.dart';

List<ListTile> widgetsToDraw = [];

class NewsDrawer extends StatefulWidget {
  @override
  _NewsDrawerState createState() => _NewsDrawerState();
}

class _NewsDrawerState extends State<NewsDrawer> {
  void drawWidgets() {
    savedArticles.forEach((article) {
      var articleWidget = ListTile(
        leading: Image.network(article['image']),
        title: Text(article['title']),
        key: Key(article['key']),
        onTap: () => Get.toNamed('/article', arguments: {
          'title': article['title'],
          'author': article['author'],
          'image': article['image'],
          'url': article['url'],
          'key': article['key'],
          'description': article['description'],
        }),
      );
      widgetsToDraw.forEach((listTile) {
        print(listTile.key);
      });
      if (!widgetsToDraw.any((listTile) => listTile.key == articleWidget.key)) {
        widgetsToDraw.add(articleWidget);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    try {
      drawWidgets();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Welcome to\n',
                style: GoogleFonts.newsCycle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Flutter News',
                      style:
                          GoogleFonts.luckiestGuy(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
          ),
          Center(
            child: Text(
              'Bookmarked articles',
              style: GoogleFonts.newsCycle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          widgetsToDraw == null
              ? const Center(child: Text('No favorite articles yet'))
              : Column(
                  children: widgetsToDraw,
                ),
        ],
      ),
    );
  }
}
