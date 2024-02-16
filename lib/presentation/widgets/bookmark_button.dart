import 'package:flutter/material.dart';

class BookmarkButton extends StatefulWidget {
  bool isBookmarked;
  BookmarkButton({Key? key, required this.isBookmarked}) : super(key: key);

  @override
  _BookmarkButtonState createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          widget.isBookmarked = !widget.isBookmarked;
        });
      },
      icon: Icon(
        widget.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
        color: widget.isBookmarked ? Colors.amber : Colors.black87,
      ),
    );
  }
}
