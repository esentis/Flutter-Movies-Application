import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';

dynamic arguments;

class SearchResults extends StatefulWidget {
  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  @override
  void initState() {
    super.initState();
    arguments = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter Movies API',
          style: TextStyle(
            fontSize: 28,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 15,
          ),
          child: ListView.separated(
            itemCount: arguments['results'].length,
            itemBuilder: (context, index) => ListTile(
              leading: arguments['results'][index]['poster_path'] != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.network(
                        '$baseImgUrl${arguments['results'][index]['poster_path']}',
                      ),
                    )
                  : Image.asset('assets/images/404_actor.png'),
              title: Text(
                arguments['results'][index]['title'],
                style: GoogleFonts.newsCycle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(arguments['results'][index]['release_date'],
                  style: GoogleFonts.newsCycle(
                    fontSize: 15,
                  )),
              trailing: Text(
                '${arguments['results'][index]['vote_average']}/10',
                style: GoogleFonts.newsCycle(
                  fontSize: 20,
                ),
              ),
            ),
            separatorBuilder: (context, index) => const Divider(),
          ),
        ),
      ),
    );
  }
}
