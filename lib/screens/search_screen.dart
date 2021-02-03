import 'package:date_format/date_format.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:news_api/components/general/apptitle.dart';
import 'package:news_api/networking/connection.dart';
import 'package:news_api/states/themestate.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:news_api/models/movie_search_results.dart';
import '../constants.dart';
import 'package:provider/provider.dart';

bool _isLoading = false;

class SearchResults extends StatefulWidget {
  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  MovieSearchResults searchResults;
  @override
  void initState() {
    super.initState();
    searchResults = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    var themeState = context.watch<SetThemeState>();
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            themeState.selectedTheme == ThemeSelected.light
                ? const Color(0xFFf7f7f7)
                : const Color(0xFF0f4c75),
            themeState.selectedTheme == ThemeSelected.light
                ? const Color(0xFF198FD8).withOpacity(0.4)
                : const Color(0xFF1b262c),
          ],
        ),
      ),
      child: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: SafeArea(
          child: ResponsiveBuilder(
            builder: (context, sizingInformation) => Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: themeState.selectedTheme == ThemeSelected.dark
                    ? const Color(0xff1a1a2e).withOpacity(0.2)
                    : Colors.white.withOpacity(0.2),
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
                toolbarHeight: sizingInformation.isMobile
                    ? sizingInformation.isTablet
                        ? 110
                        : 110
                    : 140,
                leading: Builder(
                  builder: (BuildContext context) => IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      size: 40,
                      color: themeState.selectedTheme == ThemeSelected.dark
                          ? const Color(0xFFf7f7f7)
                          : Colors.black.withOpacity(0.5),
                    ),
                    onPressed: Get.back,
                  ),
                ),
                title: AppTitle(
                  onSearchTap: () {},
                  searchIconColor:
                      themeState.selectedTheme == ThemeSelected.dark
                          ? const Color(0xFFf7f7f7)
                          : Colors.black.withOpacity(0.5),
                  settingsIconColor:
                      themeState.selectedTheme == ThemeSelected.dark
                          ? const Color(0xFFf7f7f7)
                          : Colors.black.withOpacity(0.5),
                ),
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 15,
                  ),
                  child: searchResults.results.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'No results',
                              style: GoogleFonts.newsCycle(
                                fontSize: 45,
                                fontWeight: FontWeight.bold,
                                color: themeState.selectedTheme ==
                                        ThemeSelected.dark
                                    ? Colors.white
                                    : const Color(0xFFEC1E79),
                              ),
                            ),
                            const Expanded(
                              child: FlareActor(
                                'assets/animations/not_found_404.flr',
                                alignment: Alignment.center,
                                fit: BoxFit.contain,
                                animation: 'idle',
                              ),
                            ),
                          ],
                        )
                      : ListView.separated(
                          itemCount: searchResults.results.length,
                          itemBuilder: (context, index) => ListTile(
                            onTap: () async {
                              var movieCredits = await getCredits(
                                  searchResults.results[index].id);
                              var movieDetails = await getMovie(
                                  searchResults.results[index].id);
                              await Get.toNamed('/movie',
                                  arguments: [
                                        movieDetails,
                                        movieCredits,
                                        index,
                                        'search'
                                      ] ??
                                      '');
                            },
                            leading: searchResults.results[index].posterPath !=
                                    null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(60),
                                    child: Image.network(
                                      '$baseImgUrl${searchResults.results[index].posterPath}',
                                    ),
                                  )
                                : Image.asset('assets/images/404_actor.png'),
                            title: Text(
                              searchResults.results[index].title,
                              style: GoogleFonts.newsCycle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: themeState.selectedTheme ==
                                        ThemeSelected.dark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            subtitle: Text(
                                formatDate(
                                    searchResults.results[index].releaseDate,
                                    [d, '-', M, '-', yy]),
                                style: GoogleFonts.newsCycle(
                                  fontSize: 15,
                                  color: themeState.selectedTheme ==
                                          ThemeSelected.dark
                                      ? Colors.white
                                      : Colors.black,
                                )),
                            trailing: Text(
                              '${searchResults.results[index].voteAverage}/10',
                              style: GoogleFonts.newsCycle(
                                fontSize: 20,
                                color: themeState.selectedTheme ==
                                        ThemeSelected.dark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                          separatorBuilder: (context, index) => const Divider(),
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
