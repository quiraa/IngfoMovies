import 'package:flutter/material.dart';
import 'package:ingfo_movies/conf/themes/typography.dart';
import 'package:ingfo_movies/features/data/models/response/search/search_result.dart';
import 'package:ingfo_movies/features/data/models/response/search/search_result_item.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AvailableMovieContent extends StatelessWidget {
  final SearchResult searchResult;
  final void Function(String imdbID) onMovieClicked;

  const AvailableMovieContent({
    Key? key,
    required this.searchResult,
    required this.onMovieClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: searchResult.Search!.length,
      padding: const EdgeInsets.all(16.0),
      separatorBuilder: (context, index) => const SizedBox(
        height: 16.0,
      ),
      itemBuilder: (context, index) {
        final SearchResultItem searchedMovie = searchResult.Search![index];
        return MovieCard(
          searchedMovie: searchedMovie,
          onMovieClicked: onMovieClicked,
        );
      },
    );
  }
}

class MovieCard extends StatelessWidget {
  final SearchResultItem searchedMovie;
  final void Function(String imdbID) onMovieClicked;

  const MovieCard({
    Key? key,
    required this.searchedMovie,
    required this.onMovieClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          onMovieClicked(searchedMovie.imdbID ?? '');
        },
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: _buildImage(),
            ),
            Expanded(
              flex: 3,
              child: _buildMovieInformation(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return CachedNetworkImage(
      imageUrl: searchedMovie.Poster ?? '',
      placeholder: (context, url) => Container(
        padding: const EdgeInsets.all(32.0),
        child: const CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => const Icon(
        Icons.error,
        color: Colors.redAccent,
        size: 48.0,
      ),
      fit: BoxFit.cover,
      width: 144,
      height: 164,
    );
  }

  Widget _buildMovieInformation() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            searchedMovie.Title ?? '',
            style: MovieTypography.movieCardTitle,
            overflow: TextOverflow.clip,
            softWrap: true,
            maxLines: 2,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            'Type : ${searchedMovie.Type}',
            style: MovieTypography.movieCardType,
            maxLines: 1,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            'Released : ${searchedMovie.Year}',
            style: MovieTypography.movieCardYear,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
