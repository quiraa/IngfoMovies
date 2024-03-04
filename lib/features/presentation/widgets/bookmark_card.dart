import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ingfo_movies/conf/themes/typography.dart';
import 'package:ingfo_movies/features/data/models/entity/bookmark_entity.dart';

class AvailableBookmarkContent extends StatelessWidget {
  final List<BookmarkEntity> bookmarks;
  final void Function(String imdbID) onBookmarkClick;
  final void Function(String imdbID) onBookmarkDelete;

  const AvailableBookmarkContent({
    Key? key,
    required this.bookmarks,
    required this.onBookmarkClick,
    required this.onBookmarkDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: bookmarks.length,
      padding: const EdgeInsets.all(16.0),
      separatorBuilder: (context, index) => const SizedBox(
        height: 16.0,
      ),
      itemBuilder: (context, index) {
        BookmarkEntity bookmark = bookmarks[index];
        return BookmarkCard(
          bookmark: bookmark,
          onBookmarkClick: onBookmarkClick,
          onBookmarkDelete: onBookmarkDelete,
        );
      },
    );
  }
}

class BookmarkCard extends StatelessWidget {
  final BookmarkEntity bookmark;
  final void Function(String imdbID) onBookmarkClick;
  final void Function(String imdbID) onBookmarkDelete;

  const BookmarkCard({
    Key? key,
    required this.bookmark,
    required this.onBookmarkClick,
    required this.onBookmarkDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          onBookmarkClick(bookmark.imdbID);
        },
        child: Row(
          children: [
            Expanded(flex: 2, child: _buildImage()),
            const SizedBox(
              width: 8.0,
            ),
            Expanded(
              flex: 3,
              child: _buildInformation(),
            ),
            Expanded(
              child: IconButton(
                onPressed: () {
                  onBookmarkDelete(bookmark.imdbID);
                },
                icon: Icon(
                  Icons.delete_rounded,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return CachedNetworkImage(
      placeholder: (context, url) => Container(
        margin: const EdgeInsets.all(32),
        child: const CircularProgressIndicator(),
      ),
      width: 144,
      height: 186,
      errorWidget: (context, url, error) => const Icon(
        Icons.error,
        color: Colors.redAccent,
        size: 48.0,
      ),
      fit: BoxFit.cover,
      imageUrl: bookmark.photoUrl,
    );
  }

  Widget _buildInformation() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              bookmark.title,
              style: MovieTypography.movieCardTitle,
              overflow: TextOverflow.clip,
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              'Released : ${bookmark.released}',
              style: MovieTypography.movieCardType,
            ),
          ],
        ),
      ),
    );
  }
}
