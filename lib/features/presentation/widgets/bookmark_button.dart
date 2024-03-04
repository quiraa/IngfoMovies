import 'package:flutter/material.dart';

class BookmarkButton extends StatefulWidget {
  final bool isBookmark;
  final void Function() onFabClick;

  const BookmarkButton({
    Key? key,
    required this.isBookmark,
    required this.onFabClick,
  }) : super(key: key);

  @override
  _BookmarkButtonState createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: widget.onFabClick,
      child: Icon(
        widget.isBookmark
            ? Icons.bookmark_rounded
            : Icons.bookmark_border_rounded,
      ),
    );
  }
}
