import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_api/screens/main_screen.dart';

class MobileMenu extends StatefulWidget {
  const MobileMenu({
    this.pageController,
    this.activePage,
    Key key,
  }) : super(key: key);

  final PageController pageController;
  final ActivePage activePage;
  @override
  _MobileMenuState createState() => _MobileMenuState();
}

class _MobileMenuState extends State<MobileMenu> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FlatButton(
          onPressed: () {
            widget.pageController.animateToPage(
              0,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeIn,
            );
            setState(() {
              currentPage = ActivePage.upcoming;
            });
          },
          child: Text(
            'Upcoming movies',
            style: GoogleFonts.newsCycle(
              fontSize: 22,
              color: currentPage == ActivePage.upcoming
                  ? const Color(0xFFEC1E79)
                  : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        FlatButton(
          onPressed: () {
            widget.pageController.animateToPage(
              1,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeIn,
            );
            setState(() {
              currentPage = ActivePage.latest;
            });
          },
          child: Text(
            'Latest movies',
            style: GoogleFonts.newsCycle(
              fontSize: 22,
              color: currentPage == ActivePage.latest
                  ? const Color(0xFFEC1E79)
                  : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
