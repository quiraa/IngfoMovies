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
      create: (_) => injection<BookmarkBloc>()
        ..add(
          const GetAllBookmarkEvent(),
        ),
      child: Scaffold(
        body: _buildBody(),
        appBar: _buildAppBar(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Bookmark'),
      centerTitle: true,
      leading: IconButton(
        onPressed: () => AppRouter.pop(context),
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: IconButton(
            onPressed: () async {
              return _showConfirmationDialog(context);
            },
            icon: Icon(
              Icons.delete_forever_rounded,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        )
      ],
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
                  // Tidak perlu lagi memicu event GetAllBookmarkEvent di sini
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Bookmark Deleted'),
                    ),
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

  Future<void> _showConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete All Bookmarks'),
          content: const Text('Are you sure you want to delete all bookmarks?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                BlocProvider.of<BookmarkBloc>(context).add(
                  const DeleteAllBookmarkEvent(),
                );
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Delete'),
            ),
          ],
        );
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
}
