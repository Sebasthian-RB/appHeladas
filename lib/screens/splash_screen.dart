import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'language_screen.dart';

/// Pantalla de carga animada (Splash Screen)
/// Muestra el ícono principal con un suave movimiento circular
/// y mantiene la identidad visual del diseño general de la app.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotation;

  @override
  void initState() {
    super.initState();

    // Controlador para rotación suave del ícono
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    _rotation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Redirección automática tras unos segundos
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => LanguageScreen(
            onLanguageSelected: (lang) {},
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.3),
            radius: 1.2,
            colors: [
              Color(0xFF1565C0),
              Color(0xFF0D47A1),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Círculos decorativos suaves
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Ícono dentro del círculo degradado animado
                  RotationTransition(
                    turns: _rotation,
                    child: Container(
                      height: 120,
                      width: 120,
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
                        size: 64,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Nombre de la app
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
                  const SizedBox(height: 12),

                  // Lema o subtítulo breve
                  Text(
                    'Predicción y bienestar climático',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Círculos decorativos del fondo, con transparencia y sombra difusa.
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
}
