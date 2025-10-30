import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

/// Pantalla de consejos ante heladas.
/// Presenta recomendaciones claras y animadas, con opción de retroceder.
class AdviceScreen extends StatefulWidget {
  final String language;

  const AdviceScreen({super.key, required this.language});

  @override
  State<AdviceScreen> createState() => _AdviceScreenState();
}

class _AdviceScreenState extends State<AdviceScreen>
    with SingleTickerProviderStateMixin {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() => _visible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, Map<String, dynamic>> texts = {
      'es': {
        'title': 'Consejos ante heladas',
        'introTitle': 'Aprende a proteger tus cultivos y animales',
        'introText':
        'Sigue estas recomendaciones para reducir el impacto de las heladas blancas y negras en tu comunidad y recursos agrícolas.',
        'whiteFrost': 'Helada Blanca',
        'blackFrost': 'Helada Negra',
        'whiteTips': [
          'Cubrir los cultivos con mantas térmicas o plásticos.',
          'Regar ligeramente al amanecer para reducir el daño.',
          'Evitar podas o labores agrícolas nocturnas.',
        ],
        'blackTips': [
          'No regar durante la noche.',
          'Usar calefactores o fuentes de calor si es posible.',
          'Monitorear constantemente los pronósticos del clima.',
        ],
        'generalTitle': 'Recomendaciones Generales',
        'generalTips': [
          'Consultar el pronóstico del tiempo diariamente.',
          'Proteger animales en cobertizos o zonas techadas.',
          'Evitar almacenar agua al aire libre.',
        ],
      },
      'qu': {
        'title': 'Ruphaykunata hamuqkunapaq willakuykuna',
        'introTitle': 'Yurakunata llamk’aykuna qhispiy',
        'introText':
        'Kay willakuykuna ruwaspa achka manchakuyta michuykuykuna. Chaymi yurakunata sumaqta waqaychaykuyta yachay.',
        'whiteFrost': 'Ruphay Yurak (Helada Blanca)',
        'blackFrost': 'Ruphay Yana (Helada Negra)',
        'whiteTips': [
          'Yurakunata ruwanakuy mantaqa ch’askaspa qhapariy.',
          'Paqarinmi yakuwan ruwanakuy ñawpaqta hamuq ruphayta wischuypaq.',
          'Tutata ruwanakuyta ama ruwaychu.',
        ],
        'blackTips': [
          'Tutapi ama yakuwan ruwanakuychu.',
          'Sut’ichiq warmiyuq hina q’uchu ruphaykunata llamk’ay.',
          'Sapa punchaw willakuykuna qhawariy.',
        ],
        'generalTitle': 'Hatun willakuykuna',
        'generalTips': [
          'Sapa punchaw pachamamanta willakuyta qhawariy.',
          'Uywakunata ch’askasqa wasi ukupi chaskiy.',
          'Yakuta mana hawa pachapi waqaychaychu.',
        ],
      },
    };

    final t = texts[widget.language] ?? texts['es']!;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.3),
            radius: 1.2,
            colors: [Color(0xFF1565C0), Color(0xFF0D47A1)],
          ),
        ),
        child: Stack(
          children: [
            // Círculos decorativos
            Positioned(top: -100, right: -50, child: _softCircle(220, Colors.white.withOpacity(0.08))),
            Positioned(bottom: -120, left: -60, child: _softCircle(280, Colors.white.withOpacity(0.05))),
            Positioned(top: 100, left: -40, child: _softCircle(150, Colors.white.withOpacity(0.04))),

            SafeArea(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 600),
                opacity: _visible ? 1 : 0,
                child: AnimatedSlide(
                  duration: const Duration(milliseconds: 600),
                  offset: _visible ? Offset.zero : const Offset(0, 0.1),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Botón de regreso
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            icon: const Icon(
                              LucideIcons.arrowLeft,
                              color: Colors.white,
                              size: 26,
                            ),
                            onPressed: () => Navigator.pop(context),
                            tooltip: widget.language == 'qu' ? 'Kutiy' : 'Regresar',
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Ícono principal
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
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(
                            LucideIcons.cloudSun,
                            color: Colors.white,
                            size: 46,
                          ),
                        ),
                        const SizedBox(height: 18),

                        // Título y subtítulo mejor jerarquizados
                        Text(
                          t['title'] as String,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w800,
                            fontSize: 26,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          t['introTitle'] as String,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.white70,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          t['introText'] as String,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: Colors.white70,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Tarjetas de consejos
                        _buildAdviceCard(
                          title: t['whiteFrost'] as String,
                          icon: LucideIcons.cloud,
                          gradientColors: const [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
                          tips: List<String>.from(t['whiteTips'] as List),
                        ),
                        const SizedBox(height: 20),

                        _buildAdviceCard(
                          title: t['blackFrost'] as String,
                          icon: LucideIcons.snowflake,
                          gradientColors: const [Color(0xFFBBDEFB), Color(0xFF90CAF9)],
                          tips: List<String>.from(t['blackTips'] as List),
                        ),
                        const SizedBox(height: 20),

                        _buildAdviceCard(
                          title: t['generalTitle'] as String,
                          icon: LucideIcons.lightbulb,
                          gradientColors: const [Color(0xFFB3E5FC), Color(0xFF81D4FA)],
                          tips: List<String>.from(t['generalTips'] as List),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Fondo decorativo circular.
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

  /// Tarjeta con consejos.
  Widget _buildAdviceCard({
    required String title,
    required IconData icon,
    required List<String> tips,
    required List<Color> gradientColors,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: gradientColors.last.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF0D47A1), size: 24),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Color(0xFF0D47A1),
                    height: 1.2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...tips.map(
                (tip) => Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Text(
                '• $tip',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Color(0xFF1F2428),
                  height: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
