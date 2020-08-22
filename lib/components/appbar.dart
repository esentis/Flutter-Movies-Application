import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../constants.dart';

enum SettingsMenu { theme, email, linkedIn }
var _selection;

class AppTitle extends StatefulWidget {
  @override
  _AppTitleState createState() => _AppTitleState();
}

class _AppTitleState extends State<AppTitle> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
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
                if (selectedTheme == ThemeSelected.light) {
                  Get.changeTheme(ThemeData.dark());
                  selectedTheme = ThemeSelected.dark;
                } else {
                  Get.changeTheme(ThemeData.light());
                  selectedTheme = ThemeSelected.light;
                }
              });
            },
            itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<SettingsMenu>>[
              PopupMenuItem<SettingsMenu>(
                value: SettingsMenu.theme,
                child: Text(selectedTheme == ThemeSelected.dark
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
    );
  }
}
