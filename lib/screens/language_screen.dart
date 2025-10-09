import 'package:flutter/material.dart';
import '../screens/home_screen.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1D4576),
              Color(0xFF3164A0),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // LOGO / ICONO
                Icon(
                  Icons.agriculture_rounded,
                  color: const Color(0xFF75B2F0),
                  size: size.width * 0.22,
                ),
                const SizedBox(height: 24),

                // TITULO PRINCIPAL
                const Text(
                  'AgroApp',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                    letterSpacing: 0.5,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),

                // SUBTITULO
                Text(
                  'Selecciona tu idioma',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.85),
                  ),
                ),

                const SizedBox(height: 70),

                // BOTONES DE IDIOMA
                _LanguageButton(
                  label: 'Español',
                  flag: '🇪🇸',
                  backgroundColor: const Color(0xFFF6F3E8),
                  textColor: const Color(0xFF1F2428),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HomeScreen(languageCode: 'es'),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                _LanguageButton(
                  label: 'Quechua',
                  flag: '🇵🇪',
                  backgroundColor: Colors.transparent,
                  borderColor: Colors.white.withOpacity(0.8),
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HomeScreen(languageCode: 'qu'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LanguageButton extends StatelessWidget {
  final String label;
  final String flag;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;

  const _LanguageButton({
    required this.label,
    required this.flag,
    required this.onPressed,
    required this.backgroundColor,
    required this.textColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: TextButton.icon(
        onPressed: onPressed,
        icon: Text(flag, style: const TextStyle(fontSize: 20)),
        label: Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: textColor,
          ),
        ),
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          side: borderColor != null ? BorderSide(color: borderColor!) : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
