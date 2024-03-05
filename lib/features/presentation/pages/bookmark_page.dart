import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ingfo_movies/conf/routes/app_router.dart';
import 'package:ingfo_movies/conf/routes/screen_routes.dart';
import 'package:ingfo_movies/conf/themes/typography.dart';
import 'package:ingfo_movies/di/injection.dart';
import 'package:ingfo_movies/features/data/models/entity/bookmark_entity.dart';
import 'package:ingfo_movies/features/presentation/blocs/bookmark/bookmark_bloc.dart';
import 'package:ingfo_movies/features/presentation/blocs/bookmark/bookmark_event.dart';
import 'package:ingfo_movies/features/presentation/blocs/bookmark/boomark_state.dart';
import 'package:ingfo_movies/features/presentation/widgets/bookmark_card.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injection<BookmarkBloc>()
        ..add(
          const GetAllBookmarkEvent(),
        ),
      child: SafeArea(
        child: Scaffold(
          body: _buildBody(),
        ),
      ),
    );
  }

  _buildBody() {
    return BlocBuilder<BookmarkBloc, BookmarkState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case BookmarkEmptyState:
            return const Center(
              child: Text(
                'Empty Bookmark',
                style: MovieTypography.homeMessage,
              ),
            );

          case BookmarkLoadingState:
            return const Center(
              child: CircularProgressIndicator(),
            );

          case BookmarkSuccessState:
            if (state.bookmarks!.isNotEmpty) {
              return BookmarkContent(
                bookmarks: state.bookmarks!,
                onBookmarkClick: (imdbID) {
                  AppRouter.push(
                    context,
                    ScreenRoutes.movie,
                    arguments: imdbID,
                  );
                },
                onBookmarkDelete: (imdbID) {
                  BlocProvider.of<BookmarkBloc>(context).add(
                    RemoveMovieFromBookmarkEvent(imdbID),
                  );
                },
              );
            } else {
              return const Center(
                child: Text(
                  'Empty Bookmark',
                  style: MovieTypography.homeMessage,
                ),
              );
            }

          default:
            return const SizedBox();
        }
      },
    );
  }
}

class BookmarkContent extends StatelessWidget {
  final List<BookmarkEntity> bookmarks;
  final void Function(String imdbID) onBookmarkClick;
  final void Function(String imdbID) onBookmarkDelete;

  const BookmarkContent({
    Key? key,
    required this.bookmarks,
    required this.onBookmarkClick,
    required this.onBookmarkDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      floatingActionButton: _buildDeleteAllFab(context),
    );
  }

  Widget _buildBody() {
    switch (bookmarks.isNotEmpty) {
      case true:
        return AvailableBookmarkContent(
          bookmarks: bookmarks,
          onBookmarkClick: onBookmarkClick,
          onBookmarkDelete: onBookmarkDelete,
        );
      case false:
        return const Center(
          child: Text(
            'Empty Bookmark',
            style: MovieTypography.homeMessage,
          ),
        );
    }
  }

  Widget _buildDeleteAllFab(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => BlocProvider.of<BookmarkBloc>(context).add(
        const DeleteAllBookmarkEvent(),
      ),
      child: Icon(
        Icons.delete_forever_rounded,
        color: Theme.of(context).colorScheme.error,
      ),
    );
  }
}
