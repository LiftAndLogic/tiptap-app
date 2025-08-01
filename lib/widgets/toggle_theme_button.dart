import 'package:flutter/material.dart';
import 'package:tiptap/providers/ThemeProvider.dart';

class ToggleThemeButton extends StatelessWidget {
  const ToggleThemeButton({
    super.key,
    required this.themeProvider,
  });

  final ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => themeProvider.toggleTheme(), 
      icon: Icon(
        themeProvider.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round
      ),
    );
  }
}