import 'package:flutter/material.dart';
import 'package:ingfo_movies/features/presentation/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class PreferencePage extends StatelessWidget {
  const PreferencePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildDarkModeButton(context),
          ),
        ],
      ),
    );
  }

  Widget _buildDarkModeButton(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: Text(
                    'Enable Dark Mode',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Switch(
                  value: themeProvider.themeMode == ThemeMode.dark,
                  onChanged: (bool newValue) {
                    themeProvider.toggleTheme(newValue);
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
