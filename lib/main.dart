import 'package:flutter/material.dart';
import 'package:flutter_api/data/services/locators.dart';
import 'package:flutter_api/presentation/pages/home_page.dart';
import 'package:flutter_api/presentation/providers/bookmark_provider.dart';
import 'package:flutter_api/presentation/providers/movie_provider.dart';
import 'package:flutter_api/presentation/routes/route_handler.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BookmarkProvider()),
        ChangeNotifierProvider(create: (context) => MovieProvider()),
      ],
      child: MaterialApp(
        title: 'IngfoMovies',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: generateRoute,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
