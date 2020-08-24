import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_api/components/popularity.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    this.image,
    this.overlayColor,
    this.date,
    this.title,
    this.textColor,
    this.onTap,
    this.overlayHeight,
    this.width,
    this.elevation,
    this.shadowColor,
    this.borderColor,
    this.rating,
    this.ratingBannerColor,
    this.voteCount,
    this.percentage,
  });
  final String image;
  final Color overlayColor;
  final Color textColor;
  final String date;
  final String title;
  final Function onTap;
  final double overlayHeight;
  final double width;
  final double elevation;
  final Color shadowColor;
  final Color borderColor;
  final Color ratingBannerColor;
  final String rating;
  final int voteCount;
  final double percentage;

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
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 0,
                  bottom: 0,
                  top: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/images/frame.png',
                    fit: BoxFit.fill,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  top: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/images/film.png',
                    fit: BoxFit.fill,
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
                Builder(
                  builder: (BuildContext ctx) => Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 110,
                          decoration: BoxDecoration(
                            color: overlayColor,
                            shape: BoxShape.rectangle,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            title,
                            style: GoogleFonts.newsCycle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Material(
                            color: const Color(0xFFEC1E79).withOpacity(0.8),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20)),
                              side: BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 14.0),
                              child: Text(
                                date,
                                style: GoogleFonts.newsCycle(
                                  fontSize: 15,
                                  color: textColor,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 10,
                  child: PopularityRating(
                    percentage: percentage,
                    centerTextColor: Colors.white.withOpacity(0.8),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
