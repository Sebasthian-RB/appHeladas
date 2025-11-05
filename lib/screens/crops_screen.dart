// lib/screens/crops_screen.dart
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../localization/app_localizations.dart';
import 'crop_detail_screen.dart';

class CropsScreen extends StatefulWidget {
  final String languageCode;
  const CropsScreen({super.key, required this.languageCode});

  @override
  State<CropsScreen> createState() => _CropsScreenState();
}

class _CropsScreenState extends State<CropsScreen> with TickerProviderStateMixin {
  late final AnimationController _bgController;
  late final AnimationController _particlesController;

  @override
  void initState() {
    super.initState();
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat(reverse: true);

    _particlesController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _bgController.dispose();
    _particlesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations(widget.languageCode);

    final crops = {
      'maiz': t.getText('maiz'),
      'papa': t.getText('papa'),
      'olluco': t.getText('olluco'),
      'mashua': t.getText('mashua'),
      'quinua': t.getText('quinua'),
      'habas': t.getText('habas'),
      'alverjas': t.getText('alverjas'),
      'oca': t.getText('oca'),
      'cebada': t.getText('cebada'),
      'trigo': t.getText('trigo'),
      'zanahoria': t.getText('zanahoria'),
      'col': t.getText('col'),
      'lechuga': t.getText('lechuga'),
      'apio': t.getText('apio'),
      'nabo': t.getText('nabo'),
    };

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: widget.languageCode == 'qu' ? 'Kutiy' : 'Regresar',
        ),
      ),

      body: AnimatedBuilder(
        animation: _bgController,
        builder: (context, _) {
          // 🎨 Fondo dinámico azul con partículas y ondas
          final c1 = Color.lerp(const Color(0xFF1565C0), const Color(0xFF0D47A1), _bgController.value)!;
          final c2 = Color.lerp(const Color(0xFF3164A0), const Color(0xFF1D4576), 1 - _bgController.value)!;

          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [c1, c2],
              ),
            ),
            child: Stack(
              children: [
                Positioned.fill(child: _BackgroundParticles(controller: _particlesController)),
                Positioned.fill(child: _FieldCurves(controller: _bgController)),

                // Encabezado, descripción y tarjetas
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [

                      // Header
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, kToolbarHeight + 12, 20, 6),
                          child: Column(
                            children: [
                              Container(
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFF4FC3F7), Color(0xFF0288D1)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.12),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  LucideIcons.sprout,
                                  color: Colors.white,
                                  size: 44,
                                ),
                              ),
                              const SizedBox(height: 14),

                              // --- Título ---
                              Text(
                                t.getText('crops_title'),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 22,
                                  color: Colors.white,
                                  height: 1.18,
                                ),
                              ),
                              const SizedBox(height: 10),

                              // --- Descripción ---
                              Text(
                                t.getText('crops_description'),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 13,
                                  color: Colors.white70,
                                  height: 1.6,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SliverToBoxAdapter(child: SizedBox(height: 18)),

                      // Grid de cultivos
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        sliver: SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                                (context, index) {
                              final cropKey = crops.keys.elementAt(index);
                              final cropName = crops[cropKey]!;
                              return _buildCropCard(context, cropKey, cropName);
                            },
                            childCount: crops.length,
                          ),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 18,
                            crossAxisSpacing: 18,
                            childAspectRatio: 0.9,
                          ),
                        ),
                      ),

                      const SliverToBoxAdapter(child: SizedBox(height: 28)),
                    ],
                  ),
                ),


              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCropCard(BuildContext context, String cropKey, String cropName) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          splashColor: const Color(0xFF90CAF9).withOpacity(0.3),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CropDetailScreen(
                  languageCode: widget.languageCode,
                  cropName: cropName,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 🌿 Imagen circular centrada
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF64B5F6).withOpacity(0.3),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1565C0).withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/images/crops/$cropKey.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  cropName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF1D4576),
                    letterSpacing: 0.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 🌌 Fondo con partículas y curvas (azul)
class _BackgroundParticles extends StatelessWidget {
  final AnimationController controller;
  const _BackgroundParticles({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return CustomPaint(
          painter: _ParticlesPainter(controller.value),
          size: Size.infinite,
        );
      },
    );
  }
}

class _ParticlesPainter extends CustomPainter {
  final double t;
  _ParticlesPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final rnd = Random(12345);
    for (int i = 0; i < 14; i++) {
      final x = (rnd.nextDouble() * size.width + (sin(t * (i + 1)) * 30));
      final y = (rnd.nextDouble() * size.height + (cos(t * (i + 2)) * 30));
      final r = 20 + (i % 4) * 6;
      paint.color = Colors.white.withOpacity(0.025 + (i % 3) * 0.02);
      canvas.drawCircle(Offset(x % size.width, y % size.height), r.toDouble(), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlesPainter oldDelegate) => oldDelegate.t != t;
}

class _FieldCurves extends StatelessWidget {
  final AnimationController controller;
  const _FieldCurves({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _FieldPainter(controller.value),
          size: Size.infinite,
        );
      },
    );
  }
}

class _FieldPainter extends CustomPainter {
  final double t;
  _FieldPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    p.color = Colors.white.withOpacity(0.03 + 0.02 * (sin(t * pi)));

    final path = Path();
    for (int row = 0; row < 4; row++) {
      path.reset();
      final yBase = size.height * (0.28 + row * 0.14);
      path.moveTo(0, yBase);
      for (double x = 0; x <= size.width; x += 20) {
        final wave = sin((x / size.width * 2 * pi) + (t * (row + 1))) * 10;
        path.lineTo(x, yBase + wave);
      }
      canvas.drawPath(path, p);
    }
  }

  @override
  bool shouldRepaint(covariant _FieldPainter oldDelegate) => oldDelegate.t != t;
}
