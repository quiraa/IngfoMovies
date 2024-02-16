// ignore_for_file: library_private_types_in_public_api

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api/data/source/api/api_service.dart';
import 'package:flutter_api/domain/models/search/search_item.dart';
import 'package:flutter_api/domain/models/search/search_result.dart';
import 'package:flutter_api/presentation/constants/app_typography.dart';
import 'package:flutter_api/presentation/helpers/keys.dart';
import 'package:flutter_api/presentation/routes/app_router.dart';
import 'package:flutter_api/presentation/routes/screen_routes.dart';
import 'package:flutter_api/presentation/widgets/movie_card_item.dart';
import 'package:flutter_api/presentation/widgets/search_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  Future<SearchResult>? _searchFuture;
  SearchResult? searchResultData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SearchField(
          searchController: searchController,
          onSubmitted: _searchMovie,
        ),
        toolbarHeight: 86.0,
      ),
      body: _body(),
      floatingActionButton: _fabBookmark(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _fabBookmark() {
    return FloatingActionButton(
      onPressed: () {
        AppRouter().push(context, Routes.bookmark);
      },
      child: const Icon(Icons.bookmark),
    );
  }

  Widget _body() {
    if (_searchFuture == null) {
      return const Center(
        child: Text(
          'Search for a movie',
          style: AppTypography.movieCardTitle,
        ),
      );
    } else {
      return FutureBuilder<SearchResult>(
        future: _searchFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    'No Result Matches',
                    style: AppTypography.movieCardTitle,
                  ),
                );
              } else if (snapshot.hasData) {
                return _movieItem(snapshot.data!);
              } else {
                return const Center(
                  child: Text(
                    'No Data Retrieved',
                    style: AppTypography.movieCardTitle,
                  ),
                );
              }
            default:
              return const SizedBox(); // Placeholder widget
          }
        },
      );
    }
  }

  Widget _movieItem(SearchResult result) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: result.Search.length,
      itemBuilder: (context, index) {
        SearchItem item = result.Search[index];
        return MovieCardItem(
          item: item,
          onMovieClick: () {
            AppRouter().push(context, Routes.detail, arguments: item.imdbID);
          },
        );
      },
    );
  }

  void _searchMovie(String query) {
    final api = ApiService(Dio(BaseOptions(contentType: 'application/json')));
    final future = api.searchMovies(Helper.apiKey, query);
    setState(() {
      _searchFuture = future;
    });
  }
}
