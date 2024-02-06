import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_api/random_quotes.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;
  RandomQuotes? _quotes;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        _connectionStatus = result;
      });
    });
    _isLoading = false;
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await Connectivity().checkConnectivity();
    } catch (error) {
      print(error.toString());
    }

    if (!mounted) {
      return;
    }
    setState(() {
      _connectionStatus = result;
    });
  }

  Future<void> _fetchRandomQuote() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response =
          await http.get(Uri.parse('https://api.quotable.io/random'));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        RandomQuotes quotes = RandomQuotes.fromJson(jsonData);
        setState(() {
          _quotes = quotes;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        Fluttertoast.showToast(
            msg: '${response.statusCode}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
        throw Exception('Failed to load Random Quotes');
      }
    } catch (error) {
      Fluttertoast.showToast(
          msg: 'Failed to Load Random Quotes',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SimpleFlutterNetworking'),
        centerTitle: true,
      ),
      body: _connectionStatus != ConnectivityResult.none
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/quotes.png',
                        width: 128,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'Pick a Random Quote',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 24),
                      if (_quotes != null)
                        Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                                color: Colors.grey.withOpacity(0.5), width: 1),
                          ),
                          child: Container(
                            color: Theme.of(context).colorScheme.surface,
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  _quotes!.content,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.justify,
                                ),
                                const SizedBox(height: 8),
                                Text(_quotes!.author,
                                    style: const TextStyle(fontSize: 16))
                              ],
                            ),
                          ),
                        ),
                      const SizedBox(height: 20),
                      FilledButton(
                          onPressed: () {
                            _isLoading ? null : _fetchRandomQuote();
                          },
                          child: Text(
                              _isLoading ? 'Loading..' : 'Generate Quote')),
                      const SizedBox(height: 20),
                      if (_isLoading) const CircularProgressIndicator(),
                    ],
                  ),
                ),
              ),
            )
          : const Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: Text(
                  'No Internet Connection, Please activate your Intenet Connection',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
    );
  }
}
