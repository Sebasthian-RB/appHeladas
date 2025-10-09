import 'package:flutter/material.dart';
import '../localization/app_localizations.dart';

class AdviceScreen extends StatelessWidget {
  final String languageCode;

  const AdviceScreen({super.key, required this.languageCode});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations(languageCode);

    return Scaffold(
      appBar: AppBar(title: Text(t.getText('advice'))),
      body: Center(child: Text(t.getText('advice'))),
    );
  }
}
