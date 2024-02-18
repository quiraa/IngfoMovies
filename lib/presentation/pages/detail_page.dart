// ignore_for_file: library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api/data/api/api_service.dart';
import 'package:flutter_api/domain/entities/bookmark.dart';
import 'package:flutter_api/domain/models/detail/detail_movie.dart';
import 'package:flutter_api/presentation/constants/constants.dart';
import 'package:flutter_api/presentation/providers/bookmark_provider.dart';
import 'package:flutter_api/presentation/providers/internet_status_provider.dart';
import 'package:flutter_api/presentation/routes/app_router.dart';
import 'package:flutter_api/presentation/widgets/fab_bookmark.dart';
import 'package:flutter_api/presentation/widgets/text_info.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final String imdbID;
  const DetailPage({Key? key, required this.imdbID}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _isConnected = true;
  bool _isBookmarked = false;
  late BookmarkProvider _provider;
  DetailMovie? _movie;

  Future<bool> _isInternetConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  Future<void> _checkInternetConnection() async {
    bool isConnected = await _isInternetConnected();
    setState(() {
      _isConnected = isConnected;
    });
    _fetchMovieDetail();
  }

  Future<void> _fetchMovieDetail() async {
    try {
      final api = ApiService(Dio(BaseOptions(contentType: 'application/json')));
      final result = await api.getMovieDetail(Constants.apiKey, widget.imdbID);
      final isBookmarked = await _provider.isMovieBookmarked(widget.imdbID);
      setState(() {
        _movie = result;
        _isBookmarked = isBookmarked;
      });
    } catch (error) {
      debugPrint('Error on Detail: $error');
    }
  }

  void _toggleBookmark() {
    final bookmark = Bookmark(
      _movie?.imdbID ?? '',
      _movie?.Title ?? '',
      _movie?.Poster ?? '',
      _movie?.Released ?? '',
    );
    if (_isBookmarked) {
      _provider.deleteBookmarkByID(_movie?.imdbID ?? '');
      Fluttertoast.showToast(
        msg: 'Bookmark Deleted',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } else {
      _provider.addToBookmark(bookmark);
      Fluttertoast.showToast(
        msg: 'Bookmark Added',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
    setState(() {
      _isBookmarked = !_isBookmarked;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
    _fetchMovieDetail();
    _provider = Provider.of<BookmarkProvider>(context, listen: false);
  }

  @override
  void dispose() {
    super.dispose();
    _provider.getAllBookmark();
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

  Widget _buildUI() {
    return Scaffold(
      body: _movie == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _buildAppBar(),
      floatingActionButton: FabBookmark(
        isBookmark: _isBookmarked,
        onFabClick: _toggleBookmark,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildAppBar() {
    return NestedScrollView(
      headerSliverBuilder: (context, isScrolled) {
        return [
          SliverAppBar(
            leading: IconButton(
              onPressed: () => AppRouter().pop(context),
              icon: const Icon(Icons.arrow_back),
            ),
            expandedHeight: 360,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                placeholder: (context, url) {
                  return Container(
                    margin: const EdgeInsets.all(32),
                    child: const CircularProgressIndicator(),
                  );
                },
                errorWidget: (context, url, error) {
                  return const Icon(
                    Icons.error,
                    color: Colors.redAccent,
                    size: 48,
                  );
                },
                imageUrl: _movie?.Poster ?? '',
                fit: BoxFit.cover,
              ),
            ),
          )
        ];
      },
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildUiInfo(),
        ),
      ),
    );
  }

  Widget _buildUiInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _movie?.Title ?? '',
          style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                'Type: ${_movie?.Type ?? ''}',
                style: TextInfo().category,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                'Total Season: ${_movie?.totalSeasons ?? ''}',
                style: TextInfo().category,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16.0,
        ),
        Text(
          _movie?.Plot ?? '',
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        TextInfo().buildSingleInfo(
          Icons.calendar_today,
          'Released: ${_movie?.Released ?? ''}',
        ),
        const SizedBox(
          height: 16.0,
        ),
        TextInfo().buildTwoInfos(
          Icons.history,
          Icons.movie,
          'Runtime: ${_movie?.Runtime ?? ''}',
          'Type: ${_movie?.Type ?? ''}',
        ),
        const SizedBox(
          height: 16.0,
        ),
        TextInfo().buildSingleInfo(
          Icons.theater_comedy,
          'Genre: ${_movie?.Genre ?? ''}',
        ),
        const SizedBox(
          height: 16.0,
        ),
        TextInfo().buildTwoInfos(
          Icons.record_voice_over,
          Icons.movie_edit,
          'Director: ${_movie?.Director ?? ''}',
          'Writer: ${_movie?.Writer ?? ''}',
        ),
        const SizedBox(
          height: 16.0,
        ),
        TextInfo().buildSingleInfo(
          Icons.groups,
          'Actors: ${_movie?.Actors ?? ''}',
        ),
        const SizedBox(
          height: 16.0,
        ),
        TextInfo().buildTwoInfos(
          Icons.public,
          Icons.language,
          'Country: ${_movie?.Country ?? ''}',
          'Language: ${_movie?.Language ?? ''}',
        ),
        const SizedBox(
          height: 16.0,
        ),
        TextInfo().buildSingleInfo(
          Icons.military_tech,
          'Awards: ${_movie?.Awards ?? ''}',
        ),
      ],
    );
  }
}
