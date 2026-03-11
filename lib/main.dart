import 'package:flutter/material.dart';
import 'screens/root_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const KorenApp());
}

class KorenApp extends StatelessWidget {
  const KorenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Koren',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const RootScreen(),
    );
  }
}
