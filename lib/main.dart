import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:news_api/screens/movie_screen.dart';
import 'package:news_api/screens/main_screen.dart';
import 'package:news_api/screens/search_screen.dart';
import 'package:news_api/states/loadingstate.dart';
import 'package:news_api/states/themestate.dart';
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
        ListenableProvider<SetThemeState>(
          create: (_) => SetThemeState(selectedTheme: ThemeSelected.dark),
        ),
        ListenableProvider<SetLoading>(
          create: (_) => SetLoading(isLoading: false),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        getPages: [
          GetPage(name: '/', page: () => MainScreen()),
          GetPage(name: '/search', page: () => SearchResults()),
          GetPage(
            name: '/movie',
            page: () => MovieScreen(),
          ),
        ],
        title: 'Flutter Movies Api',
        home: MainScreen(),
      ),
    );
  }
}
