import 'package:flutter/material.dart';
import 'package:ingfo_movies/features/presentation/pages/bookmark_page.dart';
import 'package:ingfo_movies/features/presentation/pages/preference_page.dart';
import 'package:ingfo_movies/features/presentation/pages/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home_rounded),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmark_rounded),
            icon: Icon(Icons.bookmark_outline_rounded),
            label: 'Bookmark',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings_rounded),
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
        onDestinationSelected: onItemTapped,
      ),
    );
  }

  final List<Widget> _screens = <Widget>[
    const SearchPage(),
    const BookmarkPage(),
    const PreferencePage(),
  ];
}
