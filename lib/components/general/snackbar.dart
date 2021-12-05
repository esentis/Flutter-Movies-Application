import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';

SnackbarController buildSnackbar({
  required SizingInformation sizingInformation,
  required String titleText,
  Color? backgroundColor,
  Color? borderColor,
  double? fontSize,
}) {
  return Get.snackbar(
    '',
    '',
    maxWidth: sizingInformation.isMobile ? 270 : 350,
    duration: const Duration(milliseconds: 800),
    backgroundColor: backgroundColor,
    borderRadius: 20,
    borderColor: borderColor,
    borderWidth: 5,
    titleText: Text(
      titleText,
      textAlign: TextAlign.center,
      style: GoogleFonts.newsCycle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}
