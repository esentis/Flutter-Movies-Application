import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PopularityRating extends StatelessWidget {
  const PopularityRating({
    @required this.percentage,
    @required this.centerTextColor,
  });
  final Color centerTextColor;
  final double percentage;
  LinearGradient getGradient(percentage) {
    if (percentage <= 20) {
      return const LinearGradient(colors: [
        Colors.redAccent,
        Colors.red,
      ]);
    }
    if (percentage > 20 && percentage <= 40) {
      return const LinearGradient(colors: [
        Colors.orange,
        Colors.red,
      ]);
    }
    if (percentage > 40 && percentage <= 60) {
      return const LinearGradient(colors: [
        Colors.yellowAccent,
        Colors.orange,
        Colors.redAccent,
      ]);
    }
    if (percentage > 60 && percentage <= 80) {
      return LinearGradient(colors: [
        Colors.green[200],
        Colors.yellowAccent,
      ]);
    }
    if (percentage > 80 && percentage <= 90) {
      return LinearGradient(colors: [
        Colors.green[900],
        Colors.yellowAccent,
      ]);
    }
    if (percentage > 90) {
      return const LinearGradient(colors: [
        Colors.greenAccent,
        Colors.green,
      ]);
    }
    return const LinearGradient(colors: [Colors.red]);
  }

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 80,
      circularStrokeCap: CircularStrokeCap.round,
      animateFromLastPercent: true,
      animationDuration: 2000,
      curve: Curves.easeIn,
      lineWidth: 10,
      animation: true,
      percent: percentage / 100 > 1 ? 1 : percentage / 100,
      backgroundColor: Colors.transparent,
      linearGradient: getGradient(percentage),
      center: Text(
        '${(percentage).toString()}%',
        style: GoogleFonts.newsCycle(
          fontSize: 20,
          color: centerTextColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
