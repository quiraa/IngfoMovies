import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api/domain/entities/bookmark.dart';
import 'package:flutter_api/presentation/constants/app_typography.dart';
import 'package:flutter_api/presentation/providers/bookmark_provider.dart';
import 'package:flutter_api/presentation/routes/app_router.dart';
import 'package:flutter_api/presentation/routes/screen_routes.dart';
import 'package:provider/provider.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  late BookmarkProvider _bookmarkProvider;

  @override
  void initState() {
    super.initState();
    _bookmarkProvider = Provider.of<BookmarkProvider>(context, listen: false);
    _bookmarkProvider.getAllBookmark();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmark'),
        actions: [
          IconButton(
            onPressed: () {
              _bookmarkProvider.deleteAllBookmark();
            },
            icon: const Icon(
              Icons.delete_forever,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
      body: Consumer<BookmarkProvider>(
        builder: (context, provider, _) {
          return provider.bookmarks.isEmpty
              ? const Center(
                  child: Text(
                    'Empty Bookmark',
                    style: AppTypography.homeMessage,
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  itemCount: provider.bookmarks.length,
                  itemBuilder: (context, index) {
                    Bookmark bookmark = provider.bookmarks[index];
                    return _bookmarkCardItem(bookmark);
                  },
                );
        },
      ),
    );
  }

  Widget _bookmarkCardItem(Bookmark item) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () =>
            AppRouter().push(context, Routes.detail, arguments: item.imdbID),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: CachedNetworkImage(
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
                imageUrl: item.photoUrl,
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: AppTypography.movieCardTitle,
                        overflow: TextOverflow.clip,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'Released : ${item.released}',
                        style: AppTypography.movieCardType,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> deleteBookmarkAndRefresh(String id) async {
    await _bookmarkProvider.deleteBookmarkByID(id);
    return await _bookmarkProvider.getAllBookmark();
  }
}
