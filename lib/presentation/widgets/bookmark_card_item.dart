// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api/domain/entities/bookmark.dart';
import 'package:flutter_api/presentation/constants/app_typography.dart';

class BookmarkCardItem extends StatelessWidget {
  final Bookmark item;
  VoidCallback onBookmarkClick;
  BookmarkCardItem({
    Key? key,
    required this.item,
    required this.onBookmarkClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onBookmarkClick,
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
}
