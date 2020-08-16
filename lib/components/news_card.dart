import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
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
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                width: 3,
                color: borderColor,
              )),
          child: Container(
            height: 200,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: overlayHeight,
                    width: MediaQuery.of(context).size.width,
                    color: overlayColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14.0, vertical: 14),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '${title.substring(0, 28)}...',
                            style: GoogleFonts.newsCycle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          Text(
                            author,
                            style: GoogleFonts.newsCycle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                        ],
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
