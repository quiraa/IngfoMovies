// ignore_for_file: library_private_types_in_public_api

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api/data/api/api_service.dart';
import 'package:flutter_api/domain/models/search/search_item.dart';
import 'package:flutter_api/domain/models/search/search_result.dart';
import 'package:flutter_api/presentation/constants/app_typography.dart';
import 'package:flutter_api/presentation/constants/constants.dart';
import 'package:flutter_api/presentation/providers/internet_status_provider.dart';
import 'package:flutter_api/presentation/routes/app_router.dart';
import 'package:flutter_api/presentation/routes/screen_routes.dart';
import 'package:flutter_api/presentation/widgets/movie_card_item.dart';
import 'package:flutter_api/presentation/widgets/search_field.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isConnected = true;
  TextEditingController searchController = TextEditingController();
  Future<SearchResult>? _searchFuture;

  Future<bool> _isInternetConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  Future<void> _checkInternetConnection() async {
    bool isConnected = await _isInternetConnected();
    setState(() {
      _isConnected = isConnected;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<InternetStatusProvider>(
      builder: (context, connectionProvider, child) {
        return connectionProvider.status == ConnectionStatus.CONNECTED
            ? _buildUI()
            : _buildNoInternetMessage();
      },
    );
  }

  Widget _buildUI() {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: SearchField(
          searchController: searchController,
          onSubmitted: _searchMovie,
        ),
        toolbarHeight: 86.0,
      ),
      body: _isConnected ? _body() : _buildNoInternetMessage(),
      floatingActionButton: _fabBookmark(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _fabBookmark() {
    return FloatingActionButton.extended(
      icon: const Icon(Icons.bookmark),
      label: const Text(
        'Bookmarks',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      onPressed: () {
        AppRouter().push(context, Routes.bookmark);
      },
    );
  }

  Widget _buildNoInternetMessage() {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'No internet connection!',
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter',
                fontSize: 20.0,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            FilledButton(
              onPressed: () {
                _checkInternetConnection();
              },
              child: const Text('Reconnect'),
            )
          ],
        ),
      ),
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
    final future = api.searchMovies(Constants.apiKey, query);
    setState(() {
      _searchFuture = future;
    });
  }
}
