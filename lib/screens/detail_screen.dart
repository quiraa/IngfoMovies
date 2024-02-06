import 'package:flutter/material.dart';
import 'package:flutter_api/model/random_quotes.dart';

class DetailScreen extends StatelessWidget {
  final RandomQuotes quotes;
  const DetailScreen({Key? key, required this.quotes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Quotes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              quotes.content,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              quotes.author,
              style: const TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
