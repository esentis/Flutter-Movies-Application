import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:news_api/components/drawer.dart';
import 'package:news_api/components/news_card.dart';
import 'package:news_api/components/search_field.dart';
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
bool hasLoaded = false;
var cachedData;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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

  Future getData() async {
    var response = await searchMovies('arnold');
    hasLoaded = true;
    cachedData = response;
    logger.w(cachedData);
    return response;
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
              ? const Color(0xFFf7f7f7)
              : const Color(0xFF0f4c75),
          _selectedTheme == ThemeSelected.light
              ? const Color(0xFF198FD8)
              : const Color(0xFF1b262c),
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
                Text(
                  '${MediaQuery.of(context).size.width.round()}',
                  style: GoogleFonts.luckiestGuy(
                      fontSize: sizingInformation.isMobile ? 38 : 45,
                      color: Colors.white,
                      shadows: [
                        const Shadow(
                          color: Colors.black,
                          blurRadius: 5,
                        )
                      ]),
                ),
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
                              Row(
                                children: [
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: SearchField(
                                      borderColor: Colors.red,
                                      sizingInformation: sizingInformation,
                                      shadowColor: Colors.white,
                                      buttonColor:
                                          _selectedTheme == ThemeSelected.light
                                              ? Colors.white.withOpacity(0.6)
                                              : Colors.white,
                                      buttonTextColor: const Color(0xFFEC1E79)
                                          .withOpacity(0.7),
                                      controller: _textController,
                                      textFontSize: 30,
                                      buttonTextFontSize: 25,
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
                    child: hasLoaded
                        ? GridView.builder(
                            controller: _scrollController,
                            itemCount: cachedData['titles'].length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: getRowCount(sizingInformation),
                            ),
                            itemBuilder: (BuildContext context, int index) =>
                                Hero(
                              tag: index,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: MovieCard(
                                  title: cachedData['titles'][index]['title'],
                                  author: cachedData['titles'][index]['id'],
                                  image: cachedData['titles'][index]['image'],
                                  borderColor:
                                      const Color(0xFFe0dede).withOpacity(0.5),
                                  overlayColor: _selectedTheme ==
                                          ThemeSelected.light
                                      ? const Color(0xFF198FD8).withOpacity(0.7)
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
                                  onTap: () async {
                                    var movie = await getMovie(
                                        cachedData['titles'][index]['id']);
                                    await Get.toNamed(
                                      '/movie',
                                      arguments: [
                                        cachedData['titles'][index]['id'],
                                        cachedData['titles'][index]['image'],
                                        movie,
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          )
                        : FutureBuilder(
                            future: getData(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                var data = snapshot.data;
                                if (data.runtimeType == DioErrorType) {
                                  return Text(data.toString());
                                }
                                return GridView.builder(
                                  controller: _scrollController,
                                  itemCount: data['titles'].length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        getRowCount(sizingInformation),
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) => Hero(
                                    tag: index,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: MovieCard(
                                        title: data['titles'][index]['title'],
                                        author: data['titles'][index]['id'],
                                        image: data['titles'][index]['image'],
                                        borderColor: const Color(0xFFe0dede)
                                            .withOpacity(0.5),
                                        overlayColor: _selectedTheme ==
                                                ThemeSelected.light
                                            ? const Color(0xFF198FD8)
                                                .withOpacity(0.7)
                                            : const Color(0xFF1b262c)
                                                .withOpacity(0.7),
                                        textColor: Colors.white,
                                        elevation: _selectedTheme ==
                                                ThemeSelected.light
                                            ? 11
                                            : 10,
                                        shadowColor: _selectedTheme ==
                                                ThemeSelected.light
                                            ? Colors.black
                                            : Colors.white,
                                        overlayHeight:
                                            sizingInformation.isMobile
                                                ? 105
                                                : 115,
                                        onTap: () async {
                                          var movie = await getMovie(
                                              data['titles'][index]['id']);
                                          await Get.toNamed(
                                            '/movie',
                                            arguments: [
                                              data['titles'][index]['id'],
                                              data['titles'][index]['image'],
                                              movie,
                                            ],
                                          );
                                        },
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
// Column(
//                                       children: [
//                                         TextField(
//                                           textAlign: TextAlign.center,
//                                           controller: _textController,
//                                           style: GoogleFonts.newsCycle(
//                                             fontSize: 30,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                           onChanged: (value) {
//                                             logger.i(value);
//                                           },
//                                         ),
//                                         sizingInformation.isDesktop
//                                             ? Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     top: 14.0),
//                                                 child: FlatButton(
//                                                   shape: StadiumBorder(
//                                                     side: BorderSide(
//                                                         color: const Color(
//                                                                 0xFF1b262c)
//                                                             .withOpacity(0.3),
//                                                         width: 3),
//                                                   ),
//                                                   onPressed: () {
//                                                     {
//                                                       if (_textController
//                                                               .text.length <=
//                                                           3) {
//                                                         Get.snackbar(
//                                                           '',
//                                                           '',
//                                                           borderRadius: 20,
//                                                           borderColor:
//                                                               Colors.white,
//                                                           borderWidth: 5,
//                                                           maxWidth: 350,
//                                                           duration:
//                                                               const Duration(
//                                                                   milliseconds:
//                                                                       800),
//                                                           backgroundColor:
//                                                               Colors.redAccent[
//                                                                       400]
//                                                                   .withOpacity(
//                                                                       0.7),
//                                                           titleText: Text(
//                                                             'At least 3 characters are needed.',
//                                                             textAlign: TextAlign
//                                                                 .center,
//                                                             style: GoogleFonts
//                                                                 .newsCycle(
//                                                               fontSize:
//                                                                   sizingInformation
//                                                                           .isMobile
//                                                                       ? 20
//                                                                       : 35,
//                                                               color:
//                                                                   Colors.white,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                             ),
//                                                           ),
//                                                         );
//                                                         return;
//                                                       }
//                                                       Get.toNamed('/search',
//                                                           arguments:
//                                                               _textController
//                                                                   .text);
//                                                     }
//                                                   },
//                                                   child: Padding(
//                                                     padding: const EdgeInsets
//                                                         .symmetric(
//                                                       horizontal: 12.0,
//                                                       vertical: 4,
//                                                     ),
//                                                     child: Text(
//                                                       'Search movie',
//                                                       style: GoogleFonts.newsCycle(
//                                                           fontSize: 30,
//                                                           fontWeight:
//                                                               FontWeight.bold,
//                                                           color: _selectedTheme ==
//                                                                   ThemeSelected
//                                                                       .light
//                                                               ? const Color(
//                                                                   0xFF198FD8)
//                                                               : const Color(
//                                                                   0xFF1b262c),
//                                                           shadows: [
//                                                             Shadow(
//                                                               color: _selectedTheme ==
//                                                                       ThemeSelected
//                                                                           .light
//                                                                   ? Colors.black
//                                                                       .withOpacity(
//                                                                           0.5)
//                                                                   : Colors.white
//                                                                       .withOpacity(
//                                                                           0.5),
//                                                               blurRadius: 2,
//                                                               offset:
//                                                                   const Offset(
//                                                                       0, 2),
//                                                             )
//                                                           ]),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               )
//                                             : const SizedBox(),
//                                       ],
//                                     )
