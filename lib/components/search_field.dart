import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_api/networking/connection.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../constants.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    this.controller,
    this.textFontSize,
    this.sizingInformation,
    this.borderColor,
    this.buttonColor,
    this.buttonTextColor,
    this.shadowColor,
    this.buttonTextFontSize,
    this.hintTextColor,
    this.textColor,
    this.onClose,
  });

  final TextEditingController controller;
  final double textFontSize;
  final double buttonTextFontSize;
  final SizingInformation sizingInformation;
  final Color borderColor;
  final Color buttonColor;
  final Color buttonTextColor;
  final Color shadowColor;
  final Color hintTextColor;
  final Color textColor;
  final Function onClose;
  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            TextField(
              textAlign: TextAlign.center,
              controller: widget.controller,
              enableInteractiveSelection: true,
              onSubmitted: (value) async {
                {
                  if (value.length <= 2) {
                    Get.snackbar(
                      '',
                      '',
                      borderRadius: 20,
                      borderColor: Colors.white,
                      borderWidth: 5,
                      maxWidth: 350,
                      duration: const Duration(milliseconds: 800),
                      backgroundColor: Colors.redAccent[400].withOpacity(0.7),
                      titleText: Text(
                        'At least 3 characters are needed.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.newsCycle(
                          fontSize: widget.sizingInformation.isMobile ? 20 : 35,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                    return;
                  }
                  var response = await searchMovies(value);

                  await Get.toNamed('/search', arguments: response);
                }
              },
              toolbarOptions: const ToolbarOptions(
                copy: true,
                paste: true,
                cut: true,
                selectAll: true,
              ),
              decoration: InputDecoration(
                  filled: true,
                  enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Color(0xFFEC1E79),
                      width: 12,
                    ),
                  ),
                  disabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.red.withOpacity(0.3),
                      width: 12,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.green,
                      width: 12,
                    ),
                  ),
                  border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        width: 2,
                        color: Colors.white,
                      )),
                  hintText: !widget.sizingInformation.isDesktop
                      ? 'Search movie'
                      : 'Start typing',
                  hintStyle: GoogleFonts.newsCycle(
                    color: widget.hintTextColor,
                    fontSize: 25,
                  )),
              style: GoogleFonts.newsCycle(
                fontSize: widget.textFontSize,
                color: widget.textColor,
                fontWeight: FontWeight.bold,
              ),
              onChanged: (value) {
                logger.i(value);
              },
            ),
            Positioned(
              right: 0,
              child: GestureDetector(
                onTap: widget.onClose,
                child: const Icon(
                  Icons.close,
                  color: Colors.red,
                  size: 35,
                ),
              ),
            ),
          ],
        ),
        widget.sizingInformation.isDesktop
            ? Padding(
                padding: const EdgeInsets.only(top: 14.0),
                child: FlatButton(
                  shape: StadiumBorder(
                    side: BorderSide(
                      color: widget.borderColor,
                      width: 3,
                    ),
                  ),
                  color: widget.buttonColor,
                  onPressed: () async {
                    {
                      if (widget.controller.text.length <= 2) {
                        Get.snackbar(
                          '',
                          '',
                          borderRadius: 20,
                          borderColor: Colors.white,
                          borderWidth: 5,
                          maxWidth: 350,
                          duration: const Duration(milliseconds: 800),
                          backgroundColor:
                              Colors.redAccent[400].withOpacity(0.7),
                          titleText: Text(
                            'At least 3 characters are needed.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.newsCycle(
                              fontSize:
                                  widget.sizingInformation.isMobile ? 20 : 35,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                        return;
                      }
                      var response = await searchMovies(widget.controller.text);

                      await Get.toNamed('/search', arguments: response);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 4,
                    ),
                    child: Text(
                      'Search movie',
                      style: GoogleFonts.newsCycle(
                          fontSize: widget.buttonTextFontSize,
                          fontWeight: FontWeight.bold,
                          color: widget.buttonTextColor,
                          shadows: [
                            Shadow(
                              color: widget.shadowColor,
                              blurRadius: 2,
                              offset: const Offset(0, 2),
                            )
                          ]),
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
