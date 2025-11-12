import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../localization/app_localizations.dart';
import '../widgets/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  final String languageCode;
  final void Function(String) onLanguageSelected;

  const HomeScreen({
    super.key,
    required this.languageCode,
    required this.onLanguageSelected,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _ubicacion = "Obteniendo ubicación...";
  String _resultado = "Cargando predicción...";

  @override
  void initState() {
    super.initState();
    _obtenerUbicacion();
    _obtenerUltimoRegistro();
  }

  Future<void> _obtenerUbicacion() async {
    bool servicioHabilitado;
    LocationPermission permiso;

    servicioHabilitado = await Geolocator.isLocationServiceEnabled();
    if (!servicioHabilitado) {
      setState(() => _ubicacion = "Ubicación deshabilitada");
      return;
    }

    permiso = await Geolocator.checkPermission();
    if (permiso == LocationPermission.denied) {
      permiso = await Geolocator.requestPermission();
      if (permiso == LocationPermission.denied) {
        setState(() => _ubicacion = "Permiso de ubicación denegado");
        return;
      }
    }

    if (permiso == LocationPermission.deniedForever) {
      setState(() => _ubicacion = "Permiso de ubicación permanentemente denegado");
      return;
    }

    final posicion = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _ubicacion = "Lat: ${posicion.latitude.toStringAsFixed(4)}, Lng: ${posicion.longitude.toStringAsFixed(4)}";
    });
  }

  Future<void> _obtenerUltimoRegistro() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('registro_heladas')
        .orderBy('fecha_registro', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final data = snapshot.docs.first.data();
      final double probBlanca = (data['prob_blanca'] ?? 0).toDouble();
      final double probNegra = (data['prob_negra'] ?? 0).toDouble();
      final double probSin = (data['prob_sin_helada'] ?? 0).toDouble();

      String tipoHelada;
      if (probBlanca >= probNegra && probBlanca >= probSin) {
        tipoHelada = "Helada Blanca";
      } else if (probNegra >= probBlanca && probNegra >= probSin) {
        tipoHelada = "Helada Negra";
      } else {
        tipoHelada = "Sin Helada";
      }

      setState(() {
        _resultado = "Resultado: $tipoHelada";
      });
    } else {
      setState(() {
        _resultado = "Sin registros disponibles";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations(widget.languageCode);

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: AppDrawer(
        languageCode: widget.languageCode,
        onLanguageSelected: widget.onLanguageSelected,
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Círculo azul con ícono blanco
            Container(
              height: 42,
              width: 42,
              decoration: const BoxDecoration(
                color: Color(0xFF1D4576),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                LucideIcons.sprout,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'Achachay',
              style: TextStyle(
                color: Color(0xFF1D4576),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 24,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Ubicación actual
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
            child: Row(
              children: [
                const Icon(LucideIcons.mapPin, color: Color(0xFF1D4576)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "Ubicación: $_ubicacion",
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      color: Color(0xFF1F2428),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Resultado actual de predicción
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1D4576), Color(0xFF3164A0)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueGrey.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(LucideIcons.cloudSnow, color: Colors.white, size: 28),
                const SizedBox(width: 12),
                Text(
                  _resultado,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          const Divider(indent: 30, endIndent: 30),

          const SizedBox(height: 10),

          // Lista de registros
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('registro_heladas')
                  .orderBy('fecha_registro', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No hay datos disponibles.'));
                }

                final docs = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final data = docs[index].data() as Map<String, dynamic>;

                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      color: const Color(0xFFE9EEF5),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Clasificación: ${data['clasificacion']}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color(0xFF1D4576),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text('🌡️ Temperatura: ${data['temperatura']} °C'),
                            Text('💧 Humedad relativa: ${data['humedad_relativa']} %'),
                            Text('💨 Velocidad del aire: ${data['velocidad_aire']} m/s'),
                            Text('☁️ Nubosidad: ${data['nubosidad']} %'),
                            Text('🌫️ Punto de rocío: ${data['punto_rocio']} °C'),
                            Text('☀️ Radiación neta: ${data['radiacion_neta']} W/m²'),
                            const Divider(height: 20),
                            Text('🧊 Prob. Blanca: ${(data['prob_blanca'] * 100).toStringAsFixed(1)} %'),
                            Text('⚫ Prob. Negra: ${(data['prob_negra'] * 100).toStringAsFixed(1)} %'),
                            Text('🌿 Sin helada: ${(data['prob_sin_helada'] * 100).toStringAsFixed(1)} %'),
                            const SizedBox(height: 8),
                            Text(
                              '📅 Fecha: ${data['fecha_registro'].toDate()}',
                              style: const TextStyle(fontSize: 13, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
