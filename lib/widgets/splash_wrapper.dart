import 'package:flutter/material.dart';
import '../screens/splash_screen.dart'; // asegúrate de importar correctamente

class SplashWrapper extends StatefulWidget {
  final Widget child; // este es el contenido real de tu home

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
        ? const SplashScreen() // tu pantalla de inicio animada
        : widget.child; // luego muestra tu lógica actual intacta
  }
}
