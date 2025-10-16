import 'package:flutter/material.dart';
import '../localization/app_localizations.dart';
import '../widgets/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  final String languageCode;
  final void Function(String) onLanguageSelected;

  const HomeScreen({
    super.key,
    required this.languageCode,
    required this.onLanguageSelected,
  });


  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations(languageCode);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.getText('title'),
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color(0xFF1D4576), // azul corporativo
        elevation: 2,
      ),
      drawer: AppDrawer(
        languageCode: languageCode,
        onLanguageSelected: onLanguageSelected, // pasamos el callback
      ),
      body: Center(
        child: Text(
          t.getText('title'),
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1F2428),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF6F3E8), // color de fondo suave
    );
  }
}