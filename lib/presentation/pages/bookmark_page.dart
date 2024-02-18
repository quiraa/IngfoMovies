// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter_api/domain/entities/bookmark.dart';
import 'package:flutter_api/presentation/constants/app_typography.dart';
import 'package:flutter_api/presentation/providers/bookmark_provider.dart';
import 'package:flutter_api/presentation/routes/app_router.dart';
import 'package:flutter_api/presentation/routes/screen_routes.dart';
import 'package:flutter_api/presentation/widgets/bookmark_card_item.dart';
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
        title: const Text('My Bookmarks'),
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
                    return BookmarkCardItem(
                      item: bookmark,
                      onBookmarkClick: () {
                        return AppRouter().push(
                          context,
                          Routes.detail,
                          arguments: bookmark.imdbID,
                        );
                      },
                    );
                  },
                );
        },
      ),
    );
  }

  Future<void> deleteBookmarkAndRefresh(String id) async {
    await _bookmarkProvider.deleteBookmarkByID(id);
    return await _bookmarkProvider.getAllBookmark();
  }
}
