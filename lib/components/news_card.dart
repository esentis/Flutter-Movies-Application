import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    this.image,
    this.overlayColor,
    this.author,
    this.title,
    this.textColor,
    this.onTap,
    this.overlayHeight,
    this.width,
    this.elevation,
    this.shadowColor,
    this.borderColor,
  });
  final String image;
  final Color overlayColor;
  final Color textColor;
  final String author;
  final String title;
  final Function onTap;
  final double overlayHeight;
  final double width;
  final double elevation;
  final Color shadowColor;
  final Color borderColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Material(
          elevation: elevation,
          shadowColor: shadowColor,
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              side: BorderSide(
                width: 3,
                color: borderColor,
              )),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  child: Builder(
                    builder: (BuildContext ctx) => Container(
                      decoration: BoxDecoration(
                        color: overlayColor,
                        shape: BoxShape.rectangle,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14.0, vertical: 14),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              title,
                              style: GoogleFonts.newsCycle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                            Card(
                              color: const Color(0xFFEC1E79).withOpacity(0.8),
                              shape: const StadiumBorder(
                                  side: BorderSide(
                                color: Colors.white,
                                width: 2,
                              )),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14.0),
                                child: Text(
                                  author,
                                  style: GoogleFonts.newsCycle(
                                    fontSize: 20,
                                    color: textColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
