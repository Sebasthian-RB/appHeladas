import 'package:flutter/material.dart';
import '../localization/app_localizations.dart';

class CropsScreen extends StatelessWidget {
  final String languageCode;

  const CropsScreen({super.key, required this.languageCode});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations(languageCode);

    return Scaffold(
      appBar: AppBar(title: Text(t.getText('crops'))),
      body: Center(child: Text(t.getText('crops'))),
    );
  }
}
