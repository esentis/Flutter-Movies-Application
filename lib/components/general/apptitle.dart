import 'package:flutter/material.dart';
import 'package:news_api/components/general/menu_settings.dart';
import 'package:news_api/states/themestate.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:provider/provider.dart';

class AppTitle extends StatefulWidget {
  const AppTitle({
    this.onSearchTap,
    this.searchIconColor,
    this.settingsIconColor,
  });
  final Function? onSearchTap;
  final Color? searchIconColor;
  final Color? settingsIconColor;
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
              scale: sizingInformation.isDesktop ? 2.5 : 4.5,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            textBaseline: TextBaseline.alphabetic,
            children: [
              GestureDetector(
                onTap: widget.onSearchTap as void Function()?,
                child: Icon(
                  Icons.search,
                  color: widget.searchIconColor,
                  size: 40,
                ),
              ),
              MenuSettings(
                iconColor: widget.searchIconColor,
                themeState: themeState,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
