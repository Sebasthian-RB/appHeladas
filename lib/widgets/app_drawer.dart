import 'package:flutter/material.dart';
import '../localization/app_localizations.dart';
import '../screens/language_screen.dart';
import '../screens/crops_screen.dart';
import '../screens/advice_screen.dart';

class AppDrawer extends StatelessWidget {
  final String languageCode;
  final void Function(String) onLanguageSelected;

  const AppDrawer({
    super.key,
    required this.languageCode,
    required this.onLanguageSelected,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations(languageCode);

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.green),
            child: Center(
              child: Text(
                t.getText('title'),
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          ListTile(
            title: Text(t.getText('language')),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => LanguageScreen(
                    onLanguageSelected: onLanguageSelected,
                  ),
                ),
              );
            },
          ),

          // Opción cultivos
          ListTile(
            title: Text(t.getText('crops')),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CropsScreen(languageCode: languageCode),
                ),
              );
            },
          ),

          // Opción consejos
          ListTile(
            title: Text(t.getText('advice')),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AdviceScreen(language: languageCode),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
