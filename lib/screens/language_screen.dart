import 'package:app_heladas/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

/// Pantalla de selección de idioma.
/// Permite al usuario elegir entre Español y Quechua (Runasimi),
/// estableciendo el idioma global de la aplicación.
class LanguageScreen extends StatelessWidget {
  final void Function(String) onLanguageSelected;

  const LanguageScreen({super.key, required this.onLanguageSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.3),
            radius: 1.2,
            colors: [
              Color(0xFF1565C0), // Azul medio
              Color(0xFF0D47A1), // Azul profundo
            ],
          ),
        ),
        child: Stack(
          children: [
            // Elementos decorativos sutiles en el fondo
            Positioned(
              top: -80,
              right: -50,
              child: _softCircle(220, Colors.white.withOpacity(0.08)),
            ),
            Positioned(
              bottom: -120,
              left: -60,
              child: _softCircle(280, Colors.white.withOpacity(0.05)),
            ),
            Positioned(
              top: 120,
              left: -40,
              child: _softCircle(150, Colors.white.withOpacity(0.04)),
            ),

            // Contenido principal centrado
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Ícono representativo de la aplicación (planta creciendo)
                    Container(
                      height: 110,
                      width: 110,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF81D4FA), Color(0xFF29B6F6)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 12,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: const Icon(
                        LucideIcons.sprout,
                        color: Colors.white,
                        size: 60,
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Nombre de la aplicación
                    const Text(
                      'Achachay',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 38,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Subtítulo bilingüe
                    Text(
                      'Selecciona tu idioma / Simiykita akllay',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 60),

                    // Botón para idioma Español
                    _buildLanguageButton(
                      context,
                      text: 'Español',
                      icon: LucideIcons.globe,
                      gradientColors: const [Color(0xFF4FC3F7), Color(0xFF0288D1)],
                      onTap: () => _selectLanguageAndGo(context, 'es'),
                    ),
                    const SizedBox(height: 20),

                    // Botón para idioma Quechua (Runasimi)
                    _buildLanguageButton(
                      context,
                      text: 'Runasimi (Quechua)',
                      icon: LucideIcons.feather,
                      gradientColors: const [Color(0xFF81D4FA), Color(0xFF0277BD)],
                      onTap: () => _selectLanguageAndGo(context, 'qu'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Lógica central: notifica a MyApp y reemplaza la pila por HomeScreen con el idioma nuevo.
  void _selectLanguageAndGo(BuildContext context, String langCode) {
    // 1) Actualiza el estado global a través del callback
    onLanguageSelected(langCode);

    // 2) Reemplaza la pila de navegación y abre HomeScreen con el idioma seleccionado.
    //    Usamos pushAndRemoveUntil para evitar duplicados en la pila y forzar reconstrucción.
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => HomeScreen(languageCode: langCode, onLanguageSelected: onLanguageSelected),
      ),
          (Route<dynamic> route) => false,
    );
  }

  /// Crea un círculo decorativo suave utilizado en el fondo.
  Widget _softCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 20,
            spreadRadius: 10,
          ),
        ],
      ),
    );
  }

  /// Construye un botón de idioma con degradado y sombra.
  Widget _buildLanguageButton(
      BuildContext context, {
        required String text,
        required IconData icon,
        required List<Color> gradientColors,
        required VoidCallback onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: gradientColors.last.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 22),
            const SizedBox(width: 12),
            Text(
              text,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
