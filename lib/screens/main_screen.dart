import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:news_api/components/drawer.dart';
import 'package:news_api/components/news_card.dart';
import 'package:news_api/networking/connection.dart';
import 'package:responsive_builder/responsive_builder.dart';

var _textController = TextEditingController();
var _scrollController = ScrollController();
var _hideSearchBar = false;
enum SettingsMenu { theme, email, linkedIn }
enum ThemeSelected { dark, light }
var logger = Logger();
var _selection;
var _selectedTheme = ThemeSelected.light;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future fetchArticles() async {
    var articles = await getHeadlinesFromCountry('us');
    return articles;
  }

  void checkScrolling() {
    if (_scrollController.offset >= 10) {
      _hideSearchBar = true;
      setState(() {});
    }
    if (_scrollController.offset == 0) {
      _hideSearchBar = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(checkScrolling);
  }

  @override
  void dispose() {
    _scrollController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //var counter = context.watch<CounterController>();
    return Scaffold(
      drawer: NewsDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) => IconButton(
            icon: const Icon(
              Icons.menu,
              size: 40,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: ResponsiveBuilder(
          builder: (context, sizingInformation) => Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            textBaseline: TextBaseline.ideographic,
            children: [
              const SizedBox(),
              Text(
                'Flutter News',
                style: GoogleFonts.luckiestGuy(
                  fontSize: sizingInformation.isMobile ? 38 : 45,
                ),
              ),
              PopupMenuButton<SettingsMenu>(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                icon: const Icon(
                  Icons.more_vert,
                  size: 35,
                ),
                onSelected: (SettingsMenu result) {
                  setState(() {
                    _selection = result;
                    logger.i('Menu item selected : $_selection');
                    if (_selectedTheme == ThemeSelected.light) {
                      Get.changeTheme(ThemeData.dark());
                      _selectedTheme = ThemeSelected.dark;
                    } else {
                      Get.changeTheme(ThemeData.light());
                      _selectedTheme = ThemeSelected.light;
                    }
                  });
                },
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<SettingsMenu>>[
                  PopupMenuItem<SettingsMenu>(
                    value: SettingsMenu.theme,
                    child: Text(_selectedTheme == ThemeSelected.dark
                        ? 'Light mode'
                        : 'Dark mode'),
                  ),
                  const PopupMenuItem<SettingsMenu>(
                    value: SettingsMenu.email,
                    child: Text('Email me'),
                  ),
                  const PopupMenuItem<SettingsMenu>(
                    value: SettingsMenu.linkedIn,
                    child: Text('LinkedIn profile'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          return Padding(
            padding: EdgeInsets.only(
              top: 5.0,
              left: sizingInformation.isMobile ? 30 : 60,
              right: sizingInformation.isMobile ? 30 : 60,
            ),
            child: Column(
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  switchOutCurve: Curves.easeOut,
                  switchInCurve: Curves.easeIn,
                  key: const Key('topBar'),
                  child: !_hideSearchBar
                      ? Row(
                          children: [
                            const Icon(
                              Icons.search,
                              size: 50,
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Column(
                                children: [
                                  TextField(
                                    textAlign: TextAlign.center,
                                    controller: _textController,
                                    style: GoogleFonts.newsCycle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    onChanged: (value) {
                                      logger.i(value);
                                    },
                                  ),
                                  sizingInformation.isDesktop
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(top: 14.0),
                                          child: FlatButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            color: Colors.blueAccent
                                                .withOpacity(0.6),
                                            onPressed: () {
                                              {
                                                if (_textController
                                                        .text.length <=
                                                    3) {
                                                  Get.snackbar(
                                                    '',
                                                    '',
                                                    backgroundColor: Colors
                                                        .redAccent[400]
                                                        .withOpacity(0.7),
                                                    titleText: Text(
                                                      'At least 3 characters are needed.',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          GoogleFonts.newsCycle(
                                                        fontSize:
                                                            sizingInformation
                                                                    .isMobile
                                                                ? 20
                                                                : 35,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  );
                                                  return;
                                                }
                                                Get.toNamed('/search',
                                                    arguments:
                                                        _textController.text);
                                              }
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Search articles',
                                                style: GoogleFonts.newsCycle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            )
                          ],
                        )
                      : Text(
                          DateTime.now().toString().substring(0, 16),
                          style: GoogleFonts.newsCycle(
                            fontSize: sizingInformation.isMobile ? 20 : 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: FutureBuilder(
                      future: fetchArticles(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          var data = snapshot.data;
                          return GridView.builder(
                            controller: _scrollController,
                            itemCount: data['articles'].length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: sizingInformation.isDesktop
                                  ? 4
                                  : sizingInformation.isTablet
                                      ? 2
                                      : sizingInformation.isMobile ? 1 : 1,
                            ),
                            itemBuilder: (BuildContext context, int index) =>
                                Hero(
                              tag: data['articles'][index]['title'],
                              child: NewsCard(
                                title: data['articles'][index]['title'] ??
                                    'No title found',
                                author: data['articles'][index]['author'] ??
                                    'No author found',
                                image: data['articles'][index]['urlToImage'] ??
                                    'No image found',
                                overlayColor: Colors.blue.withOpacity(0.8),
                                textColor: Colors.white,
                                overlayHeight: 100,
                                onTap: () =>
                                    Get.toNamed('/article', arguments: {
                                  'title': data['articles'][index]['title'],
                                  'author': data['articles'][index]['author'],
                                  'image': data['articles'][index]
                                      ['urlToImage'],
                                  'url': data['articles'][index]['url'],
                                  'key': data['articles'][index]['title'],
                                  'description': data['articles'][index]
                                      ['description'],
                                }),
                              ),
                            ),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 10,
                          ),
                        );
                      }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
