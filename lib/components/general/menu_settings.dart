import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_api/constants.dart';
import 'package:news_api/states/themestate.dart';
import 'package:url_launcher/url_launcher.dart';

enum SettingsMenu { theme, email, linkedIn, source }
var _selection;

class MenuSettings extends StatelessWidget {
  const MenuSettings({
    @required this.themeState,
    @required this.iconColor,
    Key key,
  })  : assert(themeState != null, 'Required fields are missing'),
        super(key: key);

  final SetThemeState themeState;
  final Color iconColor;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SettingsMenu>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      icon: Icon(
        Icons.more_vert,
        size: 45,
        color: iconColor,
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
          const url = 'https://github.com/esentis/Flutter-Movies-Application';
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<SettingsMenu>>[
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
    );
  }
}
