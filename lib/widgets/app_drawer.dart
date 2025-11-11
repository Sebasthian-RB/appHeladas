import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
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

    final Color deepBlue = const Color(0xFF0D47A1);
    final Color softBlue = const Color(0xFF1565C0);
    final Color accent = Colors.white.withOpacity(0.9);

    return Drawer(
      elevation: 12,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [deepBlue, softBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Encabezado moderno
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    // Avatar decorativo
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white.withOpacity(0.9),
                      child: Icon(
                        LucideIcons.sprout,
                        color: deepBlue,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Texto
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            t.getText('title'),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            languageCode == 'qu'
                                ? 'Chiri Wayra Qillqas'   // Quechua
                                : languageCode == 'es'
                                ? 'Alertas de Heladas'  // Español
                                : 'Alertas de Heladas',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Opciones de navegación
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  children: [
                    _drawerItem(
                      context,
                      icon: LucideIcons.languages,
                      title: t.getText('language'),
                      color: accent,
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
                    _drawerItem(
                      context,
                      icon: LucideIcons.leaf,
                      title: t.getText('crops'),
                      color: accent,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                CropsScreen(languageCode: languageCode),
                          ),
                        );
                      },
                    ),
                    _drawerItem(
                      context,
                      icon: LucideIcons.lightbulb,
                      title: t.getText('advice'),
                      color: accent,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                AdviceScreen(language: languageCode),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              // Pie decorativo
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '© ${DateTime.now().year} Achachay',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawerItem(
      BuildContext context, {
        required IconData icon,
        required String title,
        required Color color,
        required VoidCallback onTap,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        splashColor: Colors.white24,
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          child: Row(
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Icon(
                LucideIcons.chevronRight,
                color: Colors.white54,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
