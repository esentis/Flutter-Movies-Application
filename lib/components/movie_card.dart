import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_api/components/general/popularity.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    required this.image,
    required this.overlayColor,
    required this.date,
    required this.title,
    required this.textColor,
    required this.onTap,
    required this.overlayHeight,
    required this.elevation,
    required this.shadowColor,
    required this.borderColor,
    required this.rating,
    required this.ratingBannerColor,
    required this.voteCount,
    required this.percentage,
    required this.genres,
  });
  final String image;
  final Color overlayColor;
  final Color textColor;
  final String date;
  final String? title;
  final Function onTap;
  final double overlayHeight;
  final double elevation;
  final Color shadowColor;
  final Color borderColor;
  final Color ratingBannerColor;
  final String rating;
  final int? voteCount;
  final double percentage;
  final List<Widget> genres;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap as void Function()?,
        child: ResponsiveBuilder(
          builder: (context, sizingInformation) => Material(
            elevation: elevation,
            shadowColor: shadowColor,
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                width: 3,
                color: borderColor,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
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
              child: Banner(
                location: BannerLocation.topStart,
                message: rating,
                color: const Color(0xFFEC1E79),
                textStyle: GoogleFonts.newsCycle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      const Shadow(
                        color: Colors.white,
                        blurRadius: 6,
                      ),
                      const Shadow(
                        color: Colors.black,
                        blurRadius: 6,
                      ),
                    ]),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Builder(
                      builder: (BuildContext ctx) => Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: sizingInformation.isMobile ? 60 : 110,
                              decoration: BoxDecoration(
                                color: overlayColor,
                                shape: BoxShape.rectangle,
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                title!,
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
                                color: Colors.black.withOpacity(0.8),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                  ),
                                  side: BorderSide(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14.0),
                                  child: Column(
                                    children: [
                                      ...genres,
                                      sizingInformation.isMobile
                                          ? const SizedBox()
                                          : Text(
                                              date,
                                              style: GoogleFonts.newsCycle(
                                                fontSize: 10,
                                                color: textColor,
                                              ),
                                            ),
                                    ],
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/popcorn.png',
                            fit: BoxFit.cover,
                            scale: 27,
                          ),
                          PopularityRating(
                            radius: sizingInformation.isMobile ? 50 : 70,
                            fontSize: sizingInformation.isMobile ? 14 : 20,
                            percentage: percentage,
                            centerTextColor: Colors.white,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
