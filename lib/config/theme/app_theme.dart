import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const seedColor = Color(0xFF1E1C36);

class AppTheme {
  const AppTheme({required this.isDark});

  final bool isDark;

  static setSystemUIOverlayStyle({required bool isDarkMode}) {
    final themeBrightness = isDarkMode ? Brightness.dark : Brightness.light;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarBrightness: themeBrightness,
        statusBarIconBrightness: themeBrightness,
        systemNavigationBarIconBrightness: themeBrightness,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
    );
  }

  ThemeData getTheme() {
    return ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      useMaterial3: true,
      colorSchemeSeed: seedColor,
      listTileTheme: const ListTileThemeData(iconColor: seedColor),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1E1C36),
        surfaceTintColor: Colors.transparent,
      ),
    );
  }
}
