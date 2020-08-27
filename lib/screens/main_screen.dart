import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:news_api/components/apptitle.dart';
import 'package:news_api/components/drawer.dart';
import 'package:news_api/components/loading.dart';
import 'package:news_api/components/movies_builder.dart';
import 'package:news_api/components/search_field.dart';
import 'package:news_api/networking/connection.dart';
import 'package:news_api/states/loadingstate.dart';
import 'package:news_api/states/themestate.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

var _textController = TextEditingController();
var _scrollController = ScrollController();
bool _showSearchBar = true;

var logger = Logger();

bool hasLoaded = false;
var cachedTrendingMovies;
var cachedLatestMovies;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future getData() async {
    var trendingMovies = await getTrending();
    var upcomingMovies = await getUpcomingMovies();
    hasLoaded = true;
    cachedTrendingMovies = trendingMovies;
    cachedLatestMovies = upcomingMovies;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    if (!hasLoaded) {
      getData();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    var themeState = context.watch<SetThemeState>();
    var loader = context.watch<SetLoading>();
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            themeState.selectedTheme == ThemeSelected.light
                ? const Color(0xFFf7f7f7)
                : const Color(0xFF0f4c75),
            themeState.selectedTheme == ThemeSelected.light
                ? const Color(0xFF198FD8)
                : const Color(0xFF1b262c),
          ],
        ),
      ),
      child: ModalProgressHUD(
        inAsyncCall: loader.isLoading,
        color: const Color(0xFFEC1E79),
        progressIndicator: const Loading(),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            drawer: NewsDrawer(),
            appBar: AppBar(
              backgroundColor: themeState.selectedTheme == ThemeSelected.dark
                  ? const Color(0xFF0f4c75).withOpacity(0.3)
                  : Colors.white.withOpacity(0.7),
              elevation: 15,
              shadowColor: themeState.selectedTheme == ThemeSelected.dark
                  ? const Color(0xFFf7f7f7).withOpacity(0.3)
                  : Colors.black.withOpacity(0.7),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(60),
                  bottomLeft: Radius.circular(60),
                ),
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
              title: AppTitle(
                onSearchTap: () {
                  _showSearchBar
                      ? _showSearchBar = false
                      : _showSearchBar = true;
                  setState(() {});
                },
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        switchOutCurve: Curves.easeOut,
                        switchInCurve: Curves.easeIn,
                        key: const Key('topBar'),
                        child: _showSearchBar
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    flex: 0,
                                    child: SearchField(
                                      borderColor: Colors.red,
                                      sizingInformation: sizingInformation,
                                      shadowColor: Colors.white,
                                      onClose: () {
                                        _showSearchBar = false;
                                        setState(() {});
                                      },
                                      textColor:
                                          selectedTheme == ThemeSelected.light
                                              ? Colors.black.withOpacity(0.6)
                                              : Colors.white.withOpacity(0.6),
                                      hintTextColor:
                                          selectedTheme == ThemeSelected.light
                                              ? Colors.black.withOpacity(0.6)
                                              : Colors.white.withOpacity(0.6),
                                      buttonColor:
                                          selectedTheme == ThemeSelected.light
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
                              )
                            : const SizedBox(),
                      ),
                      hasLoaded
                          ? Text(
                              'Trending Movies',
                              style: GoogleFonts.newsCycle(
                                fontSize: sizingInformation.isMobile ? 23 : 30,
                                fontWeight: FontWeight.bold,
                                color: themeState.selectedTheme ==
                                        ThemeSelected.dark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            )
                          : const SizedBox(),
                      Expanded(
                        child: hasLoaded
                            ? MoviesBuilder(
                                widgetOrigin: 'Upcoming movies',
                                rowCount: upcomingRowCount(sizingInformation),
                                data: cachedTrendingMovies,
                                itemCount:
                                    cachedTrendingMovies['results'].length,
                                sizingInformation: sizingInformation,
                                scrollDirection: Axis.horizontal,
                              )
                            : const Loading(),
                      ),
                      hasLoaded
                          ? Text(
                              'Latest Movies',
                              style: GoogleFonts.newsCycle(
                                fontSize: sizingInformation.isMobile ? 23 : 30,
                                fontWeight: FontWeight.bold,
                                color: themeState.selectedTheme ==
                                        ThemeSelected.dark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            )
                          : const SizedBox(),
                      Expanded(
                        child: hasLoaded
                            ? MoviesBuilder(
                                widgetOrigin: 'Latest movies',
                                rowCount: latestRowCount(sizingInformation),
                                data: cachedLatestMovies,
                                itemCount: cachedLatestMovies['results'].length,
                                sizingInformation: sizingInformation,
                                scrollDirection: Axis.horizontal,
                              )
                            : const Loading(),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
