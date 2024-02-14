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
        hintText: 'Search Movies',
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(32.0),
          ),
        ),
        prefixIcon: IconButton(
          onPressed: () =>
              widget.onSubmitted(widget.searchController.text.toString()),
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
      onSubmitted: (String submitted) =>
          widget.onSubmitted(widget.searchController.text.toString()),
    );
  }
}
