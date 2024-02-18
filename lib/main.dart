import 'package:flutter/material.dart';
import 'package:flutter_api/presentation/providers/internet_status_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:flutter_api/presentation/pages/home_page.dart';
import 'package:flutter_api/presentation/providers/bookmark_provider.dart';
import 'package:flutter_api/presentation/routes/route_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BookmarkProvider()),
        ChangeNotifierProvider(create: (context) => InternetStatusProvider())
      ],
      child: MaterialApp(
        title: 'IngfoMovies',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: generateRoute,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
          useMaterial3: true,
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        home: const HomePage(),
      ),
    );
  }
}
