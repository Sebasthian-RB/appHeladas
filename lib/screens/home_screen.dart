// lib/screens/home_screen.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:math';
import 'dart:async';
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

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  String _ubicacion = "Obteniendo ubicación...";
  String _resultado = "Cargando predicción...";
  String _tipoHelada = "Sin datos";
  Timer? _timer;

  // Anim controllers
  late final AnimationController _snowController;
  late final AnimationController _windController;
  late final AnimationController _sunController;

  @override
  void initState() {
    super.initState();

    _snowController = AnimationController(vsync: this, duration: const Duration(seconds: 6))..repeat();
    _windController = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat();
    _sunController = AnimationController(vsync: this, duration: const Duration(seconds: 8))..repeat();

    _obtenerUbicacion();
    _obtenerUltimoRegistro();

    // Configurar actualización automática cada 30 segundos
    _configurarActualizacionAutomatica();
  }

  void _configurarActualizacionAutomatica() {
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _obtenerUltimoRegistro();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _snowController.dispose();
    _windController.dispose();
    _sunController.dispose();
    super.dispose();
  }

  /// Obtiene la ubicación y convierte a nombre de lugar
  Future<void> _obtenerUbicacion() async {
    try {
      bool servicioHabilitado = await Geolocator.isLocationServiceEnabled();
      if (!servicioHabilitado) {
        setState(() => _ubicacion = "Ubicación deshabilitada");
        return;
      }

      LocationPermission permiso = await Geolocator.checkPermission();
      if (permiso == LocationPermission.denied) {
        permiso = await Geolocator.requestPermission();
        if (permiso == LocationPermission.denied) {
          setState(() => _ubicacion = "Permiso denegado");
          return;
        }
      }

      if (permiso == LocationPermission.deniedForever) {
        setState(() => _ubicacion = "Permiso de ubicación denegado permanentemente");
        return;
      }

      final posicion = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      try {
        final placemarks = await placemarkFromCoordinates(posicion.latitude, posicion.longitude);
        if (placemarks.isNotEmpty) {
          final p = placemarks.first;
          final parts = [
            if ((p.locality ?? '').isNotEmpty) p.locality,
            if ((p.subAdministrativeArea ?? '').isNotEmpty) p.subAdministrativeArea,
            if ((p.administrativeArea ?? '').isNotEmpty && (p.administrativeArea != p.subAdministrativeArea)) p.administrativeArea,
            if ((p.country ?? '').isNotEmpty) p.country,
          ];
          setState(() => _ubicacion = parts.join(', '));
        } else {
          setState(() => _ubicacion = "Ubicación desconocida");
        }
      } catch (e) {
        setState(() => _ubicacion = "Error al obtener nombre de lugar");
      }
    } catch (e) {
      setState(() => _ubicacion = "Error de ubicación");
    }
  }

  /// Obtiene el último registro y asigna clasificación
  Future<void> _obtenerUltimoRegistro() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('registro_heladas')
          .orderBy('fecha_registro', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        setState(() {
          _resultado = "Sin registros disponibles";
          _tipoHelada = "Sin datos";
        });
        return;
      }

      final data = snapshot.docs.first.data();
      final rawClasificacion = data['clasificacion'];

      if (rawClasificacion == null || rawClasificacion.toString().trim().isEmpty) {
        setState(() {
          _resultado = "Clasificación no disponible";
          _tipoHelada = "Sin datos";
        });
        return;
      }

      final clas = rawClasificacion.toString().trim().toLowerCase();

      String tipo;
      if (clas.contains('blanca')) {
        tipo = 'Helada Blanca';
      } else if (clas.contains('negra')) {
        tipo = 'Helada Negra';
      } else if (clas.contains('sin')) {
        tipo = 'Sin Helada';
      } else {
        tipo = 'Dato no válido';
      }

      setState(() {
        _resultado = tipo;
        _tipoHelada = tipo;
      });
    } catch (e) {
      setState(() {
        _resultado = "Error al obtener datos";
        _tipoHelada = "Sin datos";
      });
      debugPrint("Error Firestore: $e");
    }
  }

  Color _colorPorHelada(String tipo) {
    switch (tipo.toLowerCase()) {
      case 'helada blanca':
        return const Color(0xFF0288D1);
      case 'helada negra':
        return const Color(0xFF263238);
      case 'sin helada':
        return const Color(0xFF2E7D32);
      default:
        return const Color(0xFF9E9E9E);
    }
  }

  String _obtenerDescripcionHelada(String tipo) {
    switch (tipo.toLowerCase()) {
      case 'helada blanca':
        return 'Temperatura baja con humedad alta. Se forma escarcha visible en las plantas.';
      case 'helada negra':
        return 'Temperatura muy baja sin humedad. Daño interno en las plantas sin escarcha visible.';
      case 'sin helada':
        return 'Condiciones óptimas para el crecimiento de las plantas.';
      default:
        return 'Esperando datos de sensores...';
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
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 46),

            // LOGO (círculo azul con icono blanco) y título centrados - MANTENIDO
            Center(
              child: Column(
                children: [
                  Container(
                    height: 96,
                    width: 96,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D47A1),
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))],
                    ),
                    child: const Center(
                      child: Icon(LucideIcons.sprout, color: Colors.white, size: 44),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    "Achachay",
                    style: TextStyle(
                      color: Color(0xFF0D47A1),
                      fontFamily: 'Poppins',
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // UBICACIÓN (nombre del lugar) - MANTENIDO
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(LucideIcons.mapPin, color: Color(0xFF1D4576)),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      _ubicacion,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontFamily: 'Poppins', fontSize: 15, color: Color(0xFF1F2428)),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // NUEVO DISEÑO - IMAGEN CENTRAL GRANDE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  // IMAGEN GRANDE CENTRADA
                  Container(
                    height: 180,
                    width: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: _colorPorHelada(_tipoHelada).withOpacity(0.15),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // IMAGEN PRINCIPAL
                        _buildImageForHelada(_tipoHelada),

                        // ANIMACIONES SOBRE LA IMAGEN
                        if (_tipoHelada.toLowerCase().contains("blanca"))
                          AnimatedBuilder(
                            animation: _snowController,
                            builder: (_, __) {
                              return CustomPaint(
                                painter: _SnowPainter(_snowController.value),
                                size: const Size(180, 180),
                              );
                            },
                          ),

                        if (_tipoHelada.toLowerCase().contains("negra"))
                          AnimatedBuilder(
                            animation: _windController,
                            builder: (_, __) {
                              return CustomPaint(
                                painter: _WindLinesPainter(_windController.value),
                                size: const Size(180, 180),
                              );
                            },
                          ),

                        if (_tipoHelada.toLowerCase().contains("sin helada"))
                          AnimatedBuilder(
                            animation: _sunController,
                            builder: (_, __) {
                              return CustomPaint(
                                painter: _SunPainter(_sunController.value),
                                size: const Size(180, 180),
                              );
                            },
                          ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ESTADO ACTUAL - MEJORADO
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    decoration: BoxDecoration(
                      color: _colorPorHelada(_tipoHelada).withOpacity(0.05),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _colorPorHelada(_tipoHelada).withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "ESTADO ACTUAL",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _resultado,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: _colorPorHelada(_tipoHelada),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _obtenerDescripcionHelada(_tipoHelada),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            color: Colors.grey[700],
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Divider(indent: 20, endIndent: 20),

            const SizedBox(height: 8),

            // LISTA DE REGISTROS (Stream) - MEJORADO
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('registro_heladas')
                    .orderBy('fecha_registro', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return _buildLoadingState();
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return _buildEmptyState();
                  }

                  final docs = snapshot.data!.docs;
                  return _buildRegistrosList(docs);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildImageForHelada(String tipo) {
    String asset = "";

    final t = tipo.toLowerCase();

    if (t.contains('helada blanca')) {
      asset = 'assets/images/home/white_frost_plant.png';
    } else if (t.contains('helada negra')) {
      asset = 'assets/images/home/black_frost_plant.png';
    } else if (t.contains('sin helada')) {
      asset = 'assets/images/home/healthy_plant.png';
    } else {
      return Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
      );
    }

    return Image.asset(
      asset,
      fit: BoxFit.cover,
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(
            'Cargando datos...',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(LucideIcons.database, size: 48, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'No hay registros disponibles',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegistrosList(List<QueryDocumentSnapshot> docs) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: docs.length,
      itemBuilder: (context, index) {
        final data = docs[index].data() as Map<String, dynamic>;
        return _buildRegistroCard(data);
      },
    );
  }

  Widget _buildRegistroCard(Map<String, dynamic> data) {
    String clas = (data['clasificacion'] ?? '').toString();
    final temp = data['temperatura']?.toString() ?? '-';
    final hum = data['humedad_relativa']?.toString() ?? '-';
    final vel = data['velocidad_aire']?.toString() ?? '-';
    final nub = data['nubosidad']?.toString() ?? '-';
    final pr = data['punto_rocio']?.toString() ?? '-';
    final rn = data['radiacion_neta']?.toString() ?? '-';
    final pb = (data['prob_blanca'] is num) ? (data['prob_blanca'] as num) : 0;
    final pn = (data['prob_negra'] is num) ? (data['prob_negra'] as num) : 0;
    final ps = (data['prob_sin_helada'] is num) ? (data['prob_sin_helada'] as num) : 0;

    String fechaTxt = _formatearFecha(data['fecha_registro']);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: Colors.grey[100]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Clasificación: $clas',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1D4576),
                ),
              ),
              Text(
                fechaTxt,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              _buildDataChip('🌡️ $temp°C'),
              _buildDataChip('💧 $hum%'),
              _buildDataChip('💨 $vel m/s'),
              _buildDataChip('☁️ $nub'),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildProbabilityChip('🧊', pb, const Color(0xFF0288D1)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildProbabilityChip('⚫', pn, const Color(0xFF263238)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildProbabilityChip('🌿', ps, const Color(0xFF2E7D32)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDataChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12,
          color: Color(0xFF1F2428),
        ),
      ),
    );
  }

  Widget _buildProbabilityChip(String emoji, num probability, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 2),
          Text(
            '${(probability * 100).toStringAsFixed(0)}%',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  String _formatearFecha(dynamic fecha) {
    try {
      if (fecha != null && fecha is Timestamp) {
        final date = fecha.toDate();
        return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
      }
    } catch (_) {}
    return '-';
  }
}

// CustomPainters (mantenidos igual)
class _SnowPainter extends CustomPainter {
  final double progress;
  _SnowPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.9);
    final rnd = List.generate(12, (i) {
      final x = (i * 37.0 * (1 + (0.3 * (i % 3)))) % size.width;
      final y = ((progress * (i + 1) * 60) % (size.height + 60)) - 30;
      return Offset((x + (i * 7)) % size.width, y);
    });

    for (var p in rnd) {
      canvas.drawCircle(p, 2.6, paint);
      canvas.drawCircle(
        Offset(p.dx + 6, p.dy - 8),
        1.6,
        Paint()..color = paint.color.withOpacity(0.6)..style = PaintingStyle.fill,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _SnowPainter oldDelegate) => oldDelegate.progress != progress;
}

class _WindLinesPainter extends CustomPainter {
  final double progress;
  _WindLinesPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.18)..strokeWidth = 2..style = PaintingStyle.stroke;
    for (int i = 0; i < 4; i++) {
      final y = (size.height / 5) * (i + 1);
      final offset = (progress * size.width * (i + 1)) % (size.width + 80);
      final start = Offset(-80 + offset, y);
      final end = Offset(60 + offset, y + (i.isEven ? -6 : 6));
      canvas.drawPath(_wavyLine(start, end), paint);
    }
  }

  Path _wavyLine(Offset a, Offset b) {
    final p = Path();
    p.moveTo(a.dx, a.dy);
    final mid = (a + b) / 2;
    p.quadraticBezierTo(mid.dx, mid.dy - 8, b.dx, b.dy);
    return p;
  }

  @override
  bool shouldRepaint(covariant _WindLinesPainter oldDelegate) => oldDelegate.progress != progress;
}

class _SunPainter extends CustomPainter {
  final double progress;
  _SunPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final r = size.width * 0.28;
    final paint = Paint()..color = Colors.yellowAccent..style = PaintingStyle.fill;
    canvas.drawCircle(center, r, paint);

    final rayPaint = Paint()..color = Colors.yellow.withOpacity(0.9)..strokeWidth = 2.6..style = PaintingStyle.stroke;
    final rayCount = 8;
    for (int i = 0; i < rayCount; i++) {
      final angle = (i / rayCount) * 2 * 3.1415926 + progress * 2 * 3.1415926;
      final a = Offset(center.dx + r * 1.4 * cos(angle), center.dy + r * 1.4 * sin(angle));
      final b = Offset(center.dx + r * 0.95 * cos(angle), center.dy + r * 0.95 * sin(angle));
      canvas.drawLine(a, b, rayPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _SunPainter oldDelegate) => oldDelegate.progress != progress;
}