import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api/model/random_quotes.dart';
import 'package:flutter_api/screens/detail_Screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;
  late BuildContext _context;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    _context = context;
  }

  Future<void> _fetchRandomQuote() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response =
          await http.get(Uri.parse("https://api.quotable.io/random"));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        RandomQuotes quotes = RandomQuotes.fromJson(jsonData);
        Navigator.push(
            _context,
            MaterialPageRoute(
                builder: (context) => DetailScreen(quotes: quotes)));
      }
    } catch (error) {
      Fluttertoast.showToast(
          msg: 'Failed to Load Random Quotes',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
      print(error);
      throw Exception('Failed to Load Random Quotes');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'SimpleFlutterNetworking',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            const FlutterLogo(
              size: 86,
            ),
            const SizedBox(
              height: 32,
            ),
            FilledButton(
                onPressed: () {
                  _isLoading ? null : _fetchRandomQuote();
                },
                child: Text(_isLoading ? "Loading.." : "Get Random Quote")),
            const SizedBox(height: 20),
            if (_isLoading) const CircularProgressIndicator(),
          ],
        ),
      )),
    );
  }
}
