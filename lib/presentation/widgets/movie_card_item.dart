import 'package:flutter/material.dart';
import 'package:flutter_api/data/models/search/search_item.dart';
import 'package:flutter_api/presentation/constants/app_typography.dart';
import 'package:flutter_api/presentation/routes/app_router.dart';

class MovieCardItem extends StatelessWidget {
  final SearchItem item;
  VoidCallback onMovieClick;
  MovieCardItem({Key? key, required this.item, required this.onMovieClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onMovieClick,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Image.network(
                item.Poster,
                width: 144,
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
                        item.Title,
                        style: AppTypography.movieCardTitle,
                        overflow: TextOverflow.clip,
                        softWrap: true,
                        maxLines: null,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'Type : ${item.Type}',
                        style: AppTypography.movieCardType,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'Released : ${item.Year}',
                        style: AppTypography.movieCardYear,
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

/*
Text(
                    widget.item.Title,
                    style: AppTypography.movieCardTitle,
                    overflow: TextOverflow.clip,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'Type : ${widget.item.Type}',
                    style: AppTypography.movieCardType,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'Released : ${widget.item.Year}',
                    style: AppTypography.movieCardYear,
                  ),
*/
