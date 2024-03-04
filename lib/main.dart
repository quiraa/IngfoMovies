import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ingfo_movies/conf/routes/routes_config.dart';
import 'package:ingfo_movies/conf/routes/screen_routes.dart';
import 'package:ingfo_movies/conf/themes/theme.dart';
import 'package:ingfo_movies/di/injection.dart';
import 'package:ingfo_movies/features/presentation/blocs/bookmark/bookmark_bloc.dart';
import 'package:ingfo_movies/features/presentation/blocs/detail/detail_bloc.dart';
import 'package:ingfo_movies/features/presentation/blocs/home/home_bloc.dart';
import 'package:ingfo_movies/features/presentation/pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => injection<HomeBloc>(),
        ),
        BlocProvider(
          create: (_) => injection<DetailBloc>(),
        ),
        BlocProvider(
          create: (_) => injection<BookmarkBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'IngfoMovies',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        onGenerateRoute: RoutesConfig().onGenerateRoutes,
        initialRoute: ScreenRoutes.home,
        home: HomePage(),
        darkTheme: MovieTheme().darkTheme(),
        theme: MovieTheme().lightTheme(),
      ),
    );
  }
}
