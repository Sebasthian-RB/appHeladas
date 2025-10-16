import 'package:flutter/material.dart';

class AdviceScreen extends StatelessWidget {
  final String language; // 'es' o 'qu'

  const AdviceScreen({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    // Tipar correctamente el mapa
    final Map<String, Map<String, dynamic>> texts = {
      'es': {
        'title': 'Consejos ante heladas',
        'whiteFrost': 'Helada Blanca',
        'blackFrost': 'Helada Negra',
        'more': 'Ver más consejos',
        'whiteTips': [
          'Cubrir cultivos con mantas térmicas o plásticos.',
          'Regar ligeramente al amanecer para reducir el daño.',
          'Evitar podas o labores agrícolas nocturnas.'
        ],
        'blackTips': [
          'No regar durante la noche.',
          'Usar calefactores o fuentes de calor si es posible.',
          'Monitorear constantemente los pronósticos.'
        ],
      },
      'qu': {
        'title': 'Ruphaykunata hamuqkunapaq willakuykuna',
        'whiteFrost': 'Ruphay Yurak (Helada Blanca)',
        'blackFrost': 'Ruphay Yana (Helada Negra)',
        'more': 'Aswan willakuykuna rikuy',
        'whiteTips': [
          'Yurakunata ruwanakuy mantaqa ch’askaspa qhapariy.',
          'Paqarinmi yakuwan ruwanakuy ñawpaqta hamuq ruphayta wischuypaq.',
          'Tutata ruwanakuyta ama ruwaychu.'
        ],
        'blackTips': [
          'Tutapi ama yakuwan ruwanakuychu.',
          'Sut’ichiq warmiyuq hina q’uchu ruphaykunata llamk’ay.',
          'Sapa punchaw willakuykuna qhawariy.'
        ],
      }
    };

    final t = texts[language] ?? texts['es']!;

    return Scaffold(
      backgroundColor: const Color(0xFF1D4576),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1D4576),
        elevation: 0,
        title: Text(
          t['title'] as String,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1D4576), Color(0xFF3164A0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildAdviceCard(
                title: t['whiteFrost'] as String,
                icon: Icons.cloud,
                tips: List<String>.from(t['whiteTips'] as List),
              ),
              const SizedBox(height: 16),
              _buildAdviceCard(
                title: t['blackFrost'] as String,
                icon: Icons.ac_unit,
                tips: List<String>.from(t['blackTips'] as List),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF75B2F0),
        onPressed: () {},
        label: Text(
          t['more'] as String,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        icon: const Icon(Icons.tips_and_updates, color: Colors.white),
      ),
    );
  }

  Widget _buildAdviceCard({
    required String title,
    required IconData icon,
    required List<String> tips,
  }) {
    return Card(
      color: const Color(0xFFF6F3E8),
      elevation: 6,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: const Color(0xFF3164A0), size: 26),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Color(0xFF1F2428),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ...tips.map(
                  (tip) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  "• $tip",
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: Color(0xFF1F2428),
                    height: 1.4,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
