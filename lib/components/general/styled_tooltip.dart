import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_api/states/themestate.dart';
import 'package:responsive_builder/responsive_builder.dart';

class StyledTooltip extends StatelessWidget {
  const StyledTooltip({
    required this.sizingInformation,
    required this.themeState,
    required this.maxTextLength,
    required this.text,
    required this.fontSize,
    Key? key,
  }) : super(key: key);

  final SizingInformation sizingInformation;
  final SetThemeState themeState;
  final int maxTextLength;
  final String? text;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: text!,
      textStyle: GoogleFonts.newsCycle(
        fontSize: 20,
        color: Colors.white,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black,
      ),
      child: Hero(
        tag: text!,
        child: Text(
          text!.length > maxTextLength
              ? sizingInformation.isMobile
                  ? '${text.toString().substring(0, maxTextLength)}...'
                  : sizingInformation as String
              : text!,
          textAlign: TextAlign.center,
          style: GoogleFonts.newsCycle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: themeState.selectedTheme == ThemeSelected.light
                ? Colors.black
                : const Color(0xFFf7f7f7),
          ),
        ),
      ),
    );
  }
}
