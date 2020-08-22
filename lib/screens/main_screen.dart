import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:news_api/components/appbar.dart';
import 'package:news_api/components/drawer.dart';
import 'package:news_api/components/movies_builder.dart';
import 'package:news_api/components/search_field.dart';
import 'package:news_api/networking/connection.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../constants.dart';

var _textController = TextEditingController();
var _scrollController = ScrollController();
var _hideSearchBar = false;

var logger = Logger();

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

  Future getData() async {
    var response = await getTrending();
    hasLoaded = true;
    cachedData = response;
    logger.w(response);
    return response;
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(hideSearchOnScroll);
    getTrending();
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
          selectedTheme == ThemeSelected.light
              ? const Color(0xFFf7f7f7)
              : const Color(0xFF0f4c75),
          selectedTheme == ThemeSelected.light
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
          title: AppTitle(),
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
                              Text(
                                '${MediaQuery.of(context).size.width.round()}',
                                style: GoogleFonts.luckiestGuy(
                                    fontSize:
                                        sizingInformation.isMobile ? 38 : 45,
                                    color: Colors.white,
                                    shadows: [
                                      const Shadow(
                                        color: Colors.black,
                                        blurRadius: 5,
                                      )
                                    ]),
                              ),
                              Row(
                                children: [
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: SearchField(
                                      borderColor: Colors.red,
                                      sizingInformation: sizingInformation,
                                      shadowColor: Colors.white,
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
                        ? MoviesBuilder(
                            data: cachedData,
                            itemCount: cachedData['results'].length,
                            scrollController: _scrollController,
                            sizingInformation: sizingInformation,
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
                                return MoviesBuilder(
                                  data: data,
                                  itemCount: data['results'].length,
                                  scrollController: _scrollController,
                                  sizingInformation: sizingInformation,
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
