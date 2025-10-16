import 'package:flutter/material.dart';
import 'screens/language_screen.dart';
import 'screens/home_screen.dart'; // asegúrate de tener esta pantalla

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _selectedLanguage;

  void _setLanguage(String languageCode) {
    setState(() {
      _selectedLanguage = languageCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Achachay',
      theme: ThemeData(
        primaryColor: const Color(0xFF1D4576),
        scaffoldBackgroundColor: const Color(0xFFF6F3E8),
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2428),
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            color: Color(0xFF1F2428),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF3164A0),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      home: _selectedLanguage == null
          ? LanguageScreen(onLanguageSelected: _setLanguage)
          : HomeScreen(
            languageCode: _selectedLanguage!,
            onLanguageSelected: _setLanguage,
          ),
    );
  }
}
