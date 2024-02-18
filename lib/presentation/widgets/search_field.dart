// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  TextEditingController searchController;
  Function(String submitted) onSubmitted;
  SearchField(
      {Key? key, required this.searchController, required this.onSubmitted})
      : super(key: key);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.searchController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(36.0),
        ),
        hintText: 'Search Movies',
        prefixIcon: IconButton(
          onPressed: () => widget.onSubmitted(
            widget.searchController.text.toString(),
          ),
          icon: const Icon(Icons.search),
        ),
        suffixIcon: widget.searchController.text.isNotEmpty
            ? IconButton(
                onPressed: () {
                  setState(() {
                    widget.searchController.clear();
                  });
                },
                icon: const Icon(Icons.clear),
              )
            : null,
      ),
      onSubmitted: (String submitted) => widget.onSubmitted(
        widget.searchController.text.toString(),
      ),
    );
  }
}
