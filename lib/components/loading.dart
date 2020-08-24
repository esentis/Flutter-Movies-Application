import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_api/states/themestate.dart';
import 'package:provider/provider.dart';

class Loading extends StatelessWidget {
  const Loading({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeState = context.watch<SetThemeState>();
    return SpinKitThreeBounce(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(
              color: themeState.selectedTheme == ThemeSelected.light
                  ? Colors.black
                  : Colors.white,
            ),
            color: index.isEven
                ? const Color(0xFFEC1E79).withOpacity(0.8)
                : const Color(0xFF198FD8).withOpacity(0.5),
            borderRadius: index.isEven
                ? const BorderRadius.horizontal()
                : BorderRadius.circular(60),
          ),
        );
      },
    );
  }
}
