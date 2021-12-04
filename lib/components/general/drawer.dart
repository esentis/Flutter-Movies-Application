import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_api/states/themestate.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

List<Widget> widgetsToDraw = [];

class NewsDrawer extends StatefulWidget {
  @override
  _NewsDrawerState createState() => _NewsDrawerState();
}

class _NewsDrawerState extends State<NewsDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var themeState = context.watch<SetThemeState>();
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent,
        ),
        child: Material(
          child: Container(
            decoration: BoxDecoration(
              color: sizingInformation.isMobile
                  ? Colors.black
                  : Colors.transparent,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(60),
                bottomRight: Radius.circular(60),
              ),
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
            child: Drawer(
              elevation: 35,
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Column(
                      children: [
                        Image.asset('assets/images/logo.png'),
                      ],
                    ),
                  ),
                  Center(
                    child: Text(
                      'Favorite movies',
                      style: GoogleFonts.newsCycle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: themeState.selectedTheme == ThemeSelected.light
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                  ),
                  Column(
                    children: widgetsToDraw,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
