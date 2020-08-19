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
dynamic topArticle;
Widget topArticleWidget;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future getData() async {
    var response = await countryHeadlines('gr');

    Widget image = Image.asset(topArticle['articles'][0]['urlToImage']);
    topArticleWidget = image;
    topArticle = response;
    setState(() {});
    return response;
  }

  /// When a scroll is detected, serch TextField is hidden.
  void hideSearchOnScroll() {
    if (_scrollController.offset >= 10) {
      _hideSearchBar = true;
      setState(() {});
    }
    if (_scrollController.offset == 0) {
      _hideSearchBar = false;
      setState(() {});
    }
  }

  /// Returns row count based on [sizeInformation] of the device.
  int getRowCount(SizingInformation sizeInformation) {
    if (sizeInformation.isTablet) {
      return 2;
    } else if (sizeInformation.isMobile) {
      return 1;
    } else if (sizeInformation.screenSize.width >= 950 &&
        sizeInformation.screenSize.width <= 1200) {
      return 3;
    } else if (sizeInformation.screenSize.width <= 1920) {
      return 4;
    } else {
      return 5;
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(hideSearchOnScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //var counter = context.watch<CounterController>();
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          _selectedTheme == ThemeSelected.light
              ? Color(0xFFf7f7f7)
              : Color(0xFF0f4c75),
          _selectedTheme == ThemeSelected.light
              ? Color(0xFF198FD8)
              : Color(0xFF1b262c),
        ],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: NewsDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.white.withOpacity(0.2),
          elevation: 15,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          toolbarHeight: 110,
          leading: Builder(
            builder: (BuildContext context) => IconButton(
              icon: Icon(
                Icons.menu,
                size: 40,
                color: Colors.black.withOpacity(0.5),
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          title: ResponsiveBuilder(
            builder: (context, sizingInformation) => Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              textBaseline: TextBaseline.ideographic,
              children: [
                const SizedBox(),
                Image.asset(
                  'assets/images/logo.png',
                  scale: sizingInformation.isDesktop ? 2.5 : 3,
                ),
                PopupMenuButton<SettingsMenu>(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  icon: Icon(
                    Icons.more_vert,
                    size: 45,
                    color: Colors.black.withOpacity(0.7),
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
                  const SizedBox(
                    height: 10,
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    switchOutCurve: Curves.easeOut,
                    switchInCurve: Curves.easeIn,
                    key: const Key('topBar'),
                    child: !_hideSearchBar
                        ? Column(
                            children: [
                              topArticle == null
                                  ? Builder(
                                      builder: (context) => const Center(
                                          child: CircularProgressIndicator(
                                        strokeWidth: 10,
                                      )),
                                    )
                                  : topArticleWidget,
                              Row(
                                children: [
                                  Text(
                                    '${MediaQuery.of(context).size.width.round()}',
                                    style: GoogleFonts.luckiestGuy(
                                        fontSize: sizingInformation.isMobile
                                            ? 38
                                            : 45,
                                        color: Colors.white,
                                        shadows: [
                                          const Shadow(
                                            color: Colors.black,
                                            blurRadius: 5,
                                          )
                                        ]),
                                  ),
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
                                                padding: const EdgeInsets.only(
                                                    top: 14.0),
                                                child: FlatButton(
                                                  shape: StadiumBorder(
                                                    side: BorderSide(
                                                        color: const Color(
                                                                0xFF1b262c)
                                                            .withOpacity(0.3),
                                                        width: 3),
                                                  ),
                                                  color: _selectedTheme ==
                                                          ThemeSelected.light
                                                      ? Colors.white
                                                          .withOpacity(0.6)
                                                      : Colors.white,
                                                  onPressed: () {
                                                    {
                                                      if (_textController
                                                              .text.length <=
                                                          3) {
                                                        Get.snackbar(
                                                          '',
                                                          '',
                                                          borderRadius: 20,
                                                          borderColor:
                                                              Colors.white,
                                                          borderWidth: 5,
                                                          maxWidth: 350,
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      800),
                                                          backgroundColor:
                                                              Colors.redAccent[
                                                                      400]
                                                                  .withOpacity(
                                                                      0.7),
                                                          titleText: Text(
                                                            'At least 3 characters are needed.',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: GoogleFonts
                                                                .newsCycle(
                                                              fontSize:
                                                                  sizingInformation
                                                                          .isMobile
                                                                      ? 20
                                                                      : 35,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        );
                                                        return;
                                                      }
                                                      Get.toNamed('/search',
                                                          arguments:
                                                              _textController
                                                                  .text);
                                                    }
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 12.0,
                                                      vertical: 4,
                                                    ),
                                                    child: Text(
                                                      'Search articles',
                                                      style: GoogleFonts.newsCycle(
                                                          fontSize: 30,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: _selectedTheme ==
                                                                  ThemeSelected
                                                                      .light
                                                              ? const Color(
                                                                  0xFF198FD8)
                                                              : const Color(
                                                                  0xFF1b262c),
                                                          shadows: [
                                                            Shadow(
                                                              color: _selectedTheme ==
                                                                      ThemeSelected
                                                                          .light
                                                                  ? Colors.black
                                                                      .withOpacity(
                                                                          0.5)
                                                                  : Colors.white
                                                                      .withOpacity(
                                                                          0.5),
                                                              blurRadius: 2,
                                                              offset:
                                                                  const Offset(
                                                                      0, 2),
                                                            )
                                                          ]),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        : const SizedBox(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: FutureBuilder(
                        future: getData(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            var data = snapshot.data;
                            return GridView.builder(
                              controller: _scrollController,
                              itemCount: data['articles'].length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: getRowCount(sizingInformation),
                              ),
                              itemBuilder: (BuildContext context, int index) =>
                                  Hero(
                                tag: data['articles'][index]['title'],
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: NewsCard(
                                    title: data['articles'][index]['title'] ??
                                        'No title found',
                                    author: data['articles'][index]['author'] ??
                                        'No author found',
                                    image: data['articles'][index]
                                            ['urlToImage'] ??
                                        'assets/images/404.png',
                                    borderColor: const Color(0xFFe0dede)
                                        .withOpacity(0.5),
                                    overlayColor:
                                        _selectedTheme == ThemeSelected.light
                                            ? const Color(0xFF198FD8)
                                                .withOpacity(0.7)
                                            : const Color(0xFF1b262c)
                                                .withOpacity(0.7),
                                    textColor: Colors.white,
                                    elevation:
                                        _selectedTheme == ThemeSelected.light
                                            ? 11
                                            : 10,
                                    shadowColor:
                                        _selectedTheme == ThemeSelected.light
                                            ? Colors.black
                                            : Colors.white,
                                    overlayHeight:
                                        sizingInformation.isMobile ? 105 : 115,
                                    onTap: () =>
                                        Get.toNamed('/article', arguments: {
                                      'title': data['articles'][index]['title'],
                                      'author': data['articles'][index]
                                          ['author'],
                                      'image': data['articles'][index]
                                              ['urlToImage'] ??
                                          'assets/images/404.png',
                                      'url': data['articles'][index]['url'],
                                      'key': data['articles'][index]['title'],
                                      'description': data['articles'][index]
                                          ['description'],
                                    }),
                                  ),
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
      ),
    );
  }
}
