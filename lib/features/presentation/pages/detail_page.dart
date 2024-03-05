import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ingfo_movies/conf/routes/app_router.dart';
import 'package:ingfo_movies/conf/themes/typography.dart';
import 'package:ingfo_movies/di/injection.dart';
import 'package:ingfo_movies/features/data/models/entity/bookmark_entity.dart';
import 'package:ingfo_movies/features/data/models/response/detail/detail_movie.dart';
import 'package:ingfo_movies/features/presentation/blocs/bookmark/bookmark_bloc.dart';
import 'package:ingfo_movies/features/presentation/blocs/bookmark/bookmark_event.dart';
import 'package:ingfo_movies/features/presentation/blocs/bookmark/boomark_state.dart';
import 'package:ingfo_movies/features/presentation/blocs/detail/detail_bloc.dart';
import 'package:ingfo_movies/features/presentation/blocs/detail/detail_event.dart';
import 'package:ingfo_movies/features/presentation/blocs/detail/detail_state.dart';
import 'package:ingfo_movies/features/presentation/widgets/bookmark_button.dart';
import 'package:ingfo_movies/features/presentation/widgets/text_info_widget.dart';

class DetailPage extends StatelessWidget {
  final String imdbID;

  const DetailPage({Key? key, required this.imdbID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injection<DetailBloc>()
        ..add(
          GetDetailMovieEvent(imdbID),
        ),
      child: Scaffold(
        body: _buildBody(),
      ),
    );
  }

  _buildBody() {
    return BlocBuilder<DetailBloc, DetailState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case DetailLoadingState:
            return const Center(
              child: CircularProgressIndicator(),
            );

          case DetailErrorState:
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(state.error!.message!),
              ),
            );

          case DetailSuccessState:
            return BlocBuilder<BookmarkBloc, BookmarkState>(
              builder: (context, bookmarkState) {
                return DetailContent(
                  movie: state.detailMovie!,
                  bookmarkState: bookmarkState,
                );
              },
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}

class DetailContent extends StatefulWidget {
  final DetailMovie movie;
  final BookmarkState bookmarkState;

  const DetailContent({
    Key? key,
    required this.movie,
    required this.bookmarkState,
  }) : super(key: key);

  @override
  _DetailContentState createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BookmarkBloc>(context).add(
      CheckBookmarkEvent(widget.movie.imdbID ?? ''),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUi(),
      floatingActionButton: BlocBuilder<BookmarkBloc, BookmarkState>(
        builder: (context, state) {
          return _buildBookmarkFab(state);
        },
      ),
    );
  }

  Widget _buildUi() {
    return NestedScrollView(
      headerSliverBuilder: (context, isScrolled) {
        return [
          SliverAppBar(
            leading: IconButton(
              onPressed: () => AppRouter.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
            expandedHeight: 400.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: widget.movie.Poster ?? '',
                placeholder: (context, url) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                errorWidget: (context, url, error) {
                  return const Center(
                    child: Icon(
                      Icons.error_rounded,
                      color: Colors.redAccent,
                    ),
                  );
                },
                fit: BoxFit.cover,
              ),
            ),
          )
        ];
      },
      body: SingleChildScrollView(
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            widget.movie.Title ?? '',
            style: MovieTypography.movieTitle,
          ),
        ),
        _buildDetailInformation(),
      ],
    );
  }

  Widget _buildBookmarkFab(BookmarkState state) {
    if (state is BookmarkBookmarkedState) {
      return BookmarkButton(
        isBookmark: true,
        onFabClick: () {
          BlocProvider.of<BookmarkBloc>(context).add(
            RemoveMovieFromBookmarkEvent(widget.movie.imdbID ?? ''),
          );
        },
      );
    } else if (state is BookmarkNotBookmarkedState) {
      return BookmarkButton(
        isBookmark: false,
        onFabClick: () {
          final bookmark = BookmarkEntity(
            widget.movie.imdbID ?? '',
            widget.movie.Title ?? '',
            widget.movie.Poster ?? '',
            widget.movie.Released ?? '',
          );
          BlocProvider.of<BookmarkBloc>(context).add(
            AddMovieToBookmarkEvent(bookmark),
          );
        },
      );
    } else {
      // Default state
      return BookmarkButton(
        isBookmark: false,
        onFabClick: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Null is Clicked'),
            ),
          );
        },
      );
    }
  }

  Widget _buildDetailInformation() {
    return Card(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.zero,
          bottomRight: Radius.zero,
          topLeft: Radius.circular(64),
          topRight: Radius.circular(64),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextInfoWidget.buildTwoInfos(
              null,
              null,
              'Type: ${widget.movie.Type ?? ''}',
              'Total Season: ${widget.movie.totalSeasons ?? '0'}',
            ),
            const SizedBox(height: 24.0),
            Text(
              widget.movie.Plot ?? '',
              style: MovieTypography.moviePlot,
            ),
            const SizedBox(height: 24.0),
            TextInfoWidget.buildSingleInfo(
              Icons.calendar_today_rounded,
              'Released: ${widget.movie.Released ?? ''}',
            ),
            const SizedBox(height: 24.0),
            TextInfoWidget.buildTwoInfos(
              Icons.history_rounded,
              Icons.movie_rounded,
              'Runtime: ${widget.movie.Runtime ?? ''}',
              'Type: ${widget.movie.Type ?? ''}',
            ),
            const SizedBox(height: 24.0),
            TextInfoWidget.buildSingleInfo(
              Icons.theater_comedy,
              'Genre: ${widget.movie.Genre ?? ''}',
            ),
            const SizedBox(height: 24.0),
            TextInfoWidget.buildTwoInfos(
              Icons.record_voice_over_rounded,
              Icons.movie_edit,
              'Director: ${widget.movie.Director ?? ''}',
              'Writer: ${widget.movie.Writer ?? ''}',
            ),
            const SizedBox(height: 24.0),
            TextInfoWidget.buildSingleInfo(
              Icons.groups_rounded,
              'Actors: ${widget.movie.Actors ?? ''}',
            ),
            const SizedBox(height: 24.0),
            TextInfoWidget.buildTwoInfos(
              Icons.public_rounded,
              Icons.language_rounded,
              'Country: ${widget.movie.Country ?? ''}',
              'Language: ${widget.movie.Language ?? ''}',
            ),
            const SizedBox(height: 24.0),
            TextInfoWidget.buildSingleInfo(
              Icons.military_tech_rounded,
              'Awards: ${widget.movie.Awards ?? ''}',
            ),
            const SizedBox(height: 24.0),
            TextInfoWidget.buildTwoInfos(
              Icons.star_rate_rounded,
              Icons.how_to_vote_rounded,
              'imdb Rating: ${widget.movie.imdbRating ?? ''}',
              'imdb Votes: ${widget.movie.imdbVotes ?? '0'}',
            ),
            const SizedBox(height: 24.0),
            TextInfoWidget.buildSingleInfo(
              Icons.album_rounded,
              'DVD: ${widget.movie.DVD ?? ''}',
            ),
            const SizedBox(height: 24.0),
            TextInfoWidget.buildTwoInfos(
              Icons.movie_rounded,
              Icons.production_quantity_limits_rounded,
              'Box Office: ${widget.movie.BoxOffice ?? ''}',
              'Production : ${widget.movie.Production ?? '0'}',
            ),
            const SizedBox(height: 24.0),
            TextInfoWidget.buildSingleInfo(
              Icons.domain_rounded,
              'Website: ${widget.movie.Website ?? ''}',
            ),
          ],
        ),
      ),
    );
  }
}
