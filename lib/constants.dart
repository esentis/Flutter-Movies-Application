import 'package:logger/logger.dart';
import 'package:responsive_builder/responsive_builder.dart';

List<String> favMovieTitles = [];
List savedMovies = [];
var logger = Logger();

String baseImgUrl = 'https://image.tmdb.org/t/p/w600_and_h900_bestv2';

/// Returns row count based on [sizeInformation] of the device.
int trendingRowCount(SizingInformation sizeInformation) {
  if (sizeInformation.isTablet) {
    return 1;
  } else if (sizeInformation.isMobile) {
    return 1;
  } else if (sizeInformation.screenSize.width >= 950 &&
      sizeInformation.screenSize.width <= 1200) {
    return 1;
  } else if (sizeInformation.screenSize.width <= 1920) {
    return 1;
  } else {
    return 2;
  }
}

/// Returns row count based on [sizeInformation] of the device.
int upcomingRowCount(SizingInformation sizeInformation) {
  if (sizeInformation.isTablet) {
    return 1;
  } else if (sizeInformation.isMobile) {
    return 1;
  } else if (sizeInformation.screenSize.width >= 950 &&
      sizeInformation.screenSize.width <= 1200) {
    return 1;
  } else if (sizeInformation.screenSize.width <= 1920) {
    return 1;
  } else {
    return 2;
  }
}
