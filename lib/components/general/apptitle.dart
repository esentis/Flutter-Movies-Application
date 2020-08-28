import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_api/states/themestate.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants.dart';

enum SettingsMenu { theme, email, linkedIn, source }
var _selection;

class AppTitle extends StatefulWidget {
  const AppTitle({
    this.onSearchTap,
    this.searchIconColor,
    this.settingsIconColor,
  });
  final Function onSearchTap;
  final Color searchIconColor;
  final Color settingsIconColor;
  @override
  _AppTitleState createState() => _AppTitleState();
}

class _AppTitleState extends State<AppTitle> {
  @override
  Widget build(BuildContext context) {
    var themeState = context.watch<SetThemeState>();
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        textBaseline: TextBaseline.ideographic,
        children: [
          const SizedBox(),
          Hero(
            tag: 'MOVIESLOGO',
            child: Image.asset(
              'assets/images/logo.png',
              scale: sizingInformation.isDesktop ? 2.5 : 3,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            textBaseline: TextBaseline.alphabetic,
            children: [
              GestureDetector(
                  onTap: widget.onSearchTap,
                  child: Icon(
                    Icons.search,
                    color: widget.searchIconColor,
                    size: 40,
                  )),
              PopupMenuButton<SettingsMenu>(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                icon: Icon(
                  Icons.more_vert,
                  size: 45,
                  color: widget.searchIconColor,
                ),
                onSelected: (SettingsMenu result) async {
                  _selection = result;
                  logger.i('Menu item selected : $_selection');
                  if (result == SettingsMenu.theme) {
                    themeState.toggleTheme();
                  } else if (result == SettingsMenu.email) {
                    const url = 'mailto:esentakos@yahoo.gr';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  } else if (result == SettingsMenu.linkedIn) {
                    const url = 'https://www.linkedin.com/in/gleonidis/';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  } else if (result == SettingsMenu.source) {
                    const url =
                        'https://github.com/esentis/Flutter-Movies-Application';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  }
                },
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<SettingsMenu>>[
                  PopupMenuItem<SettingsMenu>(
                    value: SettingsMenu.theme,
                    child: Text(
                      themeState.selectedTheme == ThemeSelected.dark
                          ? 'Light mode'
                          : 'Dark mode',
                      style: GoogleFonts.newsCycle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  PopupMenuItem<SettingsMenu>(
                    value: SettingsMenu.email,
                    child: Text(
                      'Email me',
                      style: GoogleFonts.newsCycle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  PopupMenuItem<SettingsMenu>(
                    value: SettingsMenu.linkedIn,
                    child: Text(
                      'LinkedIn profile',
                      style: GoogleFonts.newsCycle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  PopupMenuItem<SettingsMenu>(
                    value: SettingsMenu.source,
                    child: Text(
                      'Source code',
                      style: GoogleFonts.newsCycle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
