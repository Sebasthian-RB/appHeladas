import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';

class SplashWrapper extends StatefulWidget {
  final Widget child; // Contenido de home

  const SplashWrapper({super.key, required this.child});

  @override
  State<SplashWrapper> createState() => _SplashWrapperState();
}

class _SplashWrapperState extends State<SplashWrapper> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    _startSplash();
  }

  void _startSplash() async {
    await Future.delayed(const Duration(seconds: 3)); // tiempo del splash
    if (mounted) {
      setState(() {
        _showSplash = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _showSplash
        ? const SplashScreen() // pantalla de inicio animada
        : widget.child; // muestra lógica actual
  }
}
