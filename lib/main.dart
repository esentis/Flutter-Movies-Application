import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:news_api/screens/article_screen.dart';
import 'package:news_api/screens/main_screen.dart';
import 'package:news_api/screens/search_screen.dart';
import 'package:news_api/states/test_state.dart';
import 'package:provider/provider.dart';

Future main() async {
  await DotEnv().load('.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<FavoriteArticlesState>(
            create: (_) =>
                FavoriteArticlesState(counter: 0, widgetsToDraw: [])),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        getPages: [
          GetPage(name: '/', page: () => MainScreen()),
          GetPage(name: '/search', page: () => SearchResults()),
          GetPage(
            name: '/article',
            page: () => ArticleScreen(),
            transition: Transition.cupertinoDialog,
            curve: Curves.bounceIn,
            transitionDuration: const Duration(milliseconds: 350),
          ),
        ],
        title: 'Flutter News Api',
        home: MainScreen(),
      ),
    );
  }
}
