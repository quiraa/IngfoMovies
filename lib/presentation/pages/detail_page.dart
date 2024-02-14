import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api/data/models/detail/detail_movie.dart';
import 'package:flutter_api/data/services/api_service.dart';
import 'package:flutter_api/presentation/constants/app_typography.dart';
import 'package:flutter_api/presentation/helpers/keys.dart';
import 'package:flutter_api/presentation/routes/app_router.dart';

class DetailPage extends StatefulWidget {
  final String imdbID;
  const DetailPage({Key? key, required this.imdbID}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late DetailMovie detailMovie;

  Future<void> _fetchMovieDetail() async {
    try {
      final api = ApiService(Dio(BaseOptions(contentType: 'application/json')));
      final DetailMovie result =
          await api.getMovieDetail(Helper.apiKey, widget.imdbID);
      setState(() {
        detailMovie = result;
      });
    } catch (error) {
      print('Error on Detail: ${error}');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchMovieDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverAppBar(
              leading: IconButton(
                onPressed: () => AppRouter().pop(context),
                icon: const Icon(Icons.arrow_back),
              ),
              expandedHeight: 400,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: 'Poster',
                  child: Image.network(
                    detailMovie.Poster,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(detailMovie.Title),
              ),
            )
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                detailMovie.imdbID,
                style: AppTypography.homeMessage,
              )
            ],
          ),
        ),
      ),
    );
  }
}
