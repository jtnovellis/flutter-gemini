import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gemini_app/config/router/app_router.dart';
import 'package:gemini_app/config/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  AppTheme.setSystemUIOverlayStyle(isDarkMode: true);
  runApp(ProviderScope(child: const GeminiApp()));
}

class GeminiApp extends StatelessWidget {
  const GeminiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Gemini App',
      theme: AppTheme(isDark: true).getTheme(),
      routerConfig: appRouter,
    );
  }
}
