import 'dart:math';
import 'package:flutter/material.dart';
import '../localization/app_localizations.dart';

class CropDetailScreen extends StatefulWidget {
  final String languageCode;
  final String cropName;

  const CropDetailScreen({
    Key? key,
    required this.languageCode,
    required this.cropName,
  }) : super(key: key);

  @override
  State<CropDetailScreen> createState() => _CropDetailScreenState();
}

class _CropDetailScreenState extends State<CropDetailScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _backgroundController;
  late AnimationController _snowController;
  late AnimationController _windController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  late AppLocalizations loc;

  // Mapa con nombres científicos
  final Map<String, String> _scientificNames = {
    'maiz': 'Zea mays',
    'papa': 'Solanum tuberosum',
    'olluco': 'Ullucus tuberosus',
    'mashua': 'Tropaeolum tuberosum',
    'quinua': 'Chenopodium quinoa',
    'habas': 'Vicia faba',
    'alverjas': 'Pisum sativum',
    'oca': 'Oxalis tuberosa',
    'cebada': 'Hordeum vulgare',
    'trigo': 'Triticum aestivum',
    'zanahoria': 'Daucus carota',
    'col': 'Brassica oleracea',
    'lechuga': 'Lactuca sativa',
    'apio': 'Apium graveolens',
    'nabo': 'Brassica rapa',
  };

  @override
  void initState() {
    super.initState();
    loc = AppLocalizations(widget.languageCode);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart);
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    // Fondo con movimiento
    _backgroundController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat(reverse: true);

    // Copos de nieve
    _snowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    // Viento
    _windController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _backgroundController.dispose();
    _snowController.dispose();
    _windController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const darkNavy = Color(0xFF001B44);
    const deepBlue = Color(0xFF0D47A1);
    const mediumBlue = Color(0xFF1565C0);
    const darkGrey = Color(0xFF212121);

    return Scaffold(
      body: AnimatedBuilder(
        animation: _backgroundController,
        builder: (context, child) {
          final shift = _backgroundController.value;

          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.lerp(darkNavy, deepBlue, shift)!,
                  Color.lerp(deepBlue, mediumBlue, shift)!,
                ],
              ),
            ),
            child: Stack(
              children: [
                _animatedTexture(_backgroundController),
                SafeArea(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: Colors.white,
                                  size: 26,
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                            const SizedBox(height: 10),
                            _cropImageSection(),
                            const SizedBox(height: 20),
                            _cropNameSection(),
                            const SizedBox(height: 30),
                            _mainInfoCard(deepBlue, darkGrey),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Fondo animado
  Widget _animatedTexture(AnimationController controller) => AnimatedBuilder(
    animation: controller,
    builder: (context, _) {
      return CustomPaint(
        painter: _CalmTexturePainter(controller.value),
        size: MediaQuery.of(context).size,
      );
    },
  );

  Widget _cropImageSection() => Stack(
    alignment: Alignment.center,
    children: [
      Container(
        height: 200,
        width: 200,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [Color(0xFF64B5F6), Colors.transparent],
          ),
        ),
      ),
      Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 25,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Image.asset(
            'assets/images/crops/${widget.cropName.toLowerCase()}.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    ],
  );

  Widget _cropNameSection() => Column(
    children: [
      Text(
        loc.getText(widget.cropName.toLowerCase()),
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: [
            Shadow(
              color: Colors.black38,
              blurRadius: 8,
              offset: Offset(0, 2),
            )
          ],
        ),
        textAlign: TextAlign.center,
      ),
      Text(
        _scientificNames[widget.cropName.toLowerCase()] ?? '',
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontStyle: FontStyle.italic,
          fontSize: 16,
          color: Colors.white70,
        ),
      ),
    ],
  );

  Widget _mainInfoCard(Color deepBlue, Color darkGrey) => Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 20,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _infoRow(Icons.thermostat, loc.getText('temperature_avg'),
            loc.getText('${widget.cropName.toLowerCase()}_temp'), deepBlue),
        const SizedBox(height: 20),
        _sectionTitle(Icons.description_outlined, loc.getText('description'), deepBlue),
        _textBody(loc.getText('${widget.cropName.toLowerCase()}_desc'), darkGrey),
        const SizedBox(height: 25),
        _frostCardWhite(),
        const SizedBox(height: 18),
        _frostCardBlack(),
      ],
    ),
  );

  Widget _infoRow(IconData icon, String label, String value, Color color) => Row(
    children: [
      Icon(icon, color: color),
      const SizedBox(width: 10),
      Expanded(
        child: Text(
          '$label:',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: color,
          ),
        ),
      ),
      Text(
        value,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          color: color,
          fontSize: 15,
        ),
      ),
    ],
  );

  Widget _sectionTitle(IconData icon, String title, Color color) => Row(
    children: [
      Icon(icon, color: color),
      const SizedBox(width: 8),
      Text(
        title,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          fontSize: 18,
          color: color,
        ),
      ),
    ],
  );

  Widget _textBody(String text, Color color) => Padding(
    padding: const EdgeInsets.only(top: 8),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 15,
        color: color,
        height: 1.6,
      ),
      textAlign: TextAlign.justify,
    ),
  );

  Widget _frostCardWhite() => Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: const Color(0xFFF5F7FA),
      borderRadius: BorderRadius.circular(20),
    ),
    padding: const EdgeInsets.all(18),
    child: Stack(
      children: [
        Positioned.fill(child: _snowAnimation()),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color(0xFF0D47A1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.ac_unit_rounded,
                  color: Colors.white, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loc.getText('white_frost'),
                    style: TextStyle(
                      color: Color(0xFF0D47A1),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    loc.getText('${widget.cropName.toLowerCase()}_white'),
                    style: const TextStyle(
                      color: Color(0xFF263238),
                      fontSize: 14.5,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _frostCardBlack() => Container(
    width: double.infinity,
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFF0D47A1), Color(0xFF001B44)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20),
    ),
    padding: const EdgeInsets.all(18),
    child: Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CustomPaint(
              painter: _WindPainter(_windController.value),
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color(0xFF1565C0),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.cloud_rounded,
                  color: Colors.white, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loc.getText('black_frost'),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    loc.getText('${widget.cropName.toLowerCase()}_black'),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14.5,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _snowAnimation() => AnimatedBuilder(
    animation: _snowController,
    builder: (context, _) {
      return CustomPaint(
        painter: _SnowPainter(_snowController.value),
      );
    },
  );
}

// ==========================
// Animaciones visuales
// ==========================

class _CalmTexturePainter extends CustomPainter {
  final double progress;
  _CalmTexturePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.fill;

    final random = Random(8);
    for (int i = 0; i < 6; i++) {
      final dx = size.width * random.nextDouble();
      final dy = size.height * random.nextDouble();
      final double r = 220 + sin(progress * pi * 2 + i) * 100;
      canvas.drawCircle(Offset(dx, dy), r.abs(), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _CalmTexturePainter oldDelegate) => true;
}

class _SnowPainter extends CustomPainter {
  final double progress;
  _SnowPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.9)
      ..style = PaintingStyle.fill;

    final random = Random(5);
    for (int i = 0; i < 25; i++) {
      final dx = random.nextDouble() * size.width;
      final dy = (random.nextDouble() * size.height + progress * size.height) %
          size.height;
      canvas.drawCircle(Offset(dx, dy), 2.5 + random.nextDouble() * 3, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _SnowPainter oldDelegate) => true;
}

class _WindPainter extends CustomPainter {
  final double progress;
  _WindPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < 5; i++) {
      final y = size.height * (i / 5);
      final startX = (progress * size.width + i * 100) % size.width;
      canvas.drawLine(Offset(startX - 80, y), Offset(startX + 80, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _WindPainter oldDelegate) => true;
}
