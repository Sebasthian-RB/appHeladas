import 'package:flutter/material.dart';
import '../localization/app_localizations.dart';
import '../widgets/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  final String languageCode;

  const HomeScreen({super.key, required this.languageCode});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations(languageCode);

    return Scaffold(
      appBar: AppBar(title: Text(t.getText('title'))),
      drawer: AppDrawer(languageCode: languageCode),
      body: Center(child: Text(t.getText('title'))),
    );
  }
}
