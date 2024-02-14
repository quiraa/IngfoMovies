import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api/data/models/search/search_item.dart';
import 'package:flutter_api/data/models/search/search_result.dart';
import 'package:flutter_api/data/services/api_service.dart';
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
  SearchResult? searchResultData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        title: SearchField(
          searchController: searchController,
          onSubmitted: _searchMovie,
        ),
        toolbarHeight: 86.0,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return FutureBuilder<SearchResult>(
      future: _searchMovie(searchController.text),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // ! FIX
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _movieItem(SearchResult result) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
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

// ! TRY ALTERNATIVE
  Future<SearchResult> _searchMovie(String query) async {
    try {
      final api = ApiService(Dio(BaseOptions(contentType: 'application/json')));
      final result = await api.searchMovies(Helper.apiKey, query);
      setState(() {
        searchResultData = result;
      });
    } catch (error) {
      print('Error: ${error}');
      throw error;
    }
  }
}
