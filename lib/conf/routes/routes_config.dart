import 'package:flutter/material.dart';
import 'package:ingfo_movies/conf/routes/screen_routes.dart';
import 'package:ingfo_movies/features/presentation/pages/bookmark_page.dart';
import 'package:ingfo_movies/features/presentation/pages/detail_page.dart';
import 'package:ingfo_movies/features/presentation/pages/home_page.dart';

class RoutesConfig {
  PageRoute getPageRoute({String? routeName, Widget? screen}) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => screen!,
    );
  }

  Route<dynamic> onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case ScreenRoutes.home:
        return getPageRoute(
          routeName: ScreenRoutes.home,
          screen: HomePage(),
        );

      case ScreenRoutes.movie:
        final imdbID = settings.arguments as String;
        return getPageRoute(
          routeName: ScreenRoutes.movie,
          screen: DetailPage(
            imdbID: imdbID,
          ),
        );

      case ScreenRoutes.bookmark:
        return getPageRoute(
          routeName: ScreenRoutes.bookmark,
          screen: const BookmarkPage(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No Routes Defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
