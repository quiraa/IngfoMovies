import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ingfo_movies/conf/routes/app_router.dart';
import 'package:ingfo_movies/conf/routes/screen_routes.dart';
import 'package:ingfo_movies/conf/themes/typography.dart';
import 'package:ingfo_movies/features/presentation/blocs/home/home_bloc.dart';
import 'package:ingfo_movies/features/presentation/blocs/home/home_event.dart';
import 'package:ingfo_movies/features/presentation/blocs/home/home_state.dart';
import 'package:ingfo_movies/features/presentation/providers/internet_status_provider.dart';
import 'package:ingfo_movies/features/presentation/widgets/movie_card.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late InternetStatusProvider _connectionProvider;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _connectionProvider = Provider.of<InternetStatusProvider>(
      context,
      listen: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (_connectionProvider.status == ConnectionStatus.CONNECTED) {
            return _buildMovieList();
          } else {
            return const Center(
              child: Text('No Internet Connection!'),
            );
          }
        },
      ),
      // floatingActionButton: _buildBookmarkFab(context),
    );
  }

  // Widget _buildBookmarkFab(BuildContext context) {
  //   return FloatingActionButton.extended(
  //     onPressed: () => AppRouter.push(context, ScreenRoutes.bookmark),
  //     label: const Text(
  //       'Bookmark',
  //       style: MovieTypography.category,
  //     ),
  //     icon: const Icon(Icons.bookmark_rounded),
  //   );
  // }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 86.0,
      surfaceTintColor: Colors.transparent,
      title: _buildSearchField(context),
    );
  }

  Widget _buildMovieList() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeDefaultState:
            return const Center(
              child: Text(
                'Search Movie To Get Started',
                style: MovieTypography.homeMessage,
              ),
            );

          case HomeLoadingState:
            return const Center(
              child: CircularProgressIndicator(),
            );

          case HomeErrorState:
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(state.error!.message!),
              ),
            );

          case HomeSuccessState:
            if (state.searchResult != null &&
                state.searchResult!.Search != null) {
              return AvailableMovieContent(
                searchResult: state.searchResult!,
                onMovieClicked: (imdbID) {
                  AppRouter.push(
                    context,
                    ScreenRoutes.movie,
                    arguments: imdbID,
                  );
                },
              );
            } else {
              return const Center(
                child: Text(
                  'No Movie Found',
                  style: MovieTypography.homeMessage,
                ),
              );
            }

          default:
            return const Center(
              child: Text('Search Movies'),
            );
        }
      },
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(36.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        hintText: 'Search Movies',
        prefixIcon: IconButton(
          onPressed: () {
            if (_searchController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  showCloseIcon: true,
                  dismissDirection: DismissDirection.vertical,
                  content: Text(
                    'Please in Fill the Search Field',
                    style: MovieTypography.movieCardType,
                  ),
                ),
              );
            } else {
              final query = _searchController.text.toString();
              BlocProvider.of<HomeBloc>(context).add(
                SearchMovieEvent(query),
              );
            }
          },
          icon: const Icon(Icons.search),
        ),
        suffixIcon: _searchController.text.isNotEmpty
            ? IconButton(
                onPressed: () => _searchController.clear(),
                icon: const Icon(Icons.clear),
              )
            : null,
      ),
      textInputAction: TextInputAction.search,
      onSubmitted: (String currentQuery) {
        if (_searchController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              showCloseIcon: true,
              dismissDirection: DismissDirection.vertical,
              content: Text(
                'Please Fill in the Search Field',
                style: MovieTypography.movieCardType,
              ),
            ),
          );
        } else {
          final query = _searchController.text.toString();
          BlocProvider.of<HomeBloc>(context).add(
            SearchMovieEvent(query),
          );
        }
      },
    );
  }
}
