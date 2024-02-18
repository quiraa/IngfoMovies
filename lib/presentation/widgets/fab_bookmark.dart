// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:flutter/material.dart';

class FabBookmark extends StatefulWidget {
  bool isBookmark;
  VoidCallback onFabClick;
  FabBookmark({
    Key? key,
    required this.isBookmark,
    required this.onFabClick,
  }) : super(key: key);

  @override
  _FabBookmarkState createState() => _FabBookmarkState();
}

class _FabBookmarkState extends State<FabBookmark> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: widget.onFabClick,
      child: Icon(
        widget.isBookmark ? Icons.bookmark : Icons.bookmark_border,
        color: widget.isBookmark ? Colors.amber : Colors.grey,
      ),
    );
  }
}
