import 'package:flutter/material.dart';

class CropDetailScreen extends StatelessWidget {
  final String languageCode;
  final String cropName;

  const CropDetailScreen({
    Key? key,
    required this.languageCode,
    required this.cropName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fondo blanco como pediste
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          cropName,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E7D32),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Color(0xFF2E7D32)),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📸 Imagen principal
            Center(
              child: Hero(
                tag: cropName,
                child: Container(
                  height: 220,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage('assets/images/crops/$cropName.jpg'),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.25),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // 🌿 Nombre del cultivo
            Text(
              cropName,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20),
              ),
            ),
            const SizedBox(height: 12),

            // 🌱 Descripción simulada (aquí luego pondrás tus datos reales)
            Text(
              _getCropDescription(cropName, languageCode),
              style: const TextStyle(
                fontSize: 16,
                height: 1.6,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 30),

            // 📊 Sección informativa
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF7FDF7),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE0E0E0)),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Detalles del cultivo",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "🌞 Necesita buena exposición solar\n"
                        "💧 Riego moderado y constante\n"
                        "🌱 Suelo fértil y bien drenado\n"
                        "📅 Cosecha promedio de 3 a 4 meses",
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // 🔙 Botón regresar
            Center(
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D32),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                label: const Text(
                  "Volver",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🌾 Descripciones temporales — puedes reemplazarlas por tu JSON o traducciones
  String _getCropDescription(String name, String language) {
    final descriptions = {
      'maiz': {
        'es': 'El maíz es un cultivo esencial para la alimentación y la economía rural. Se adapta a diversos climas y su ciclo productivo suele ser corto.',
      },
      'papa': {
        'es': 'La papa es un alimento básico en la dieta andina. Requiere suelos sueltos, frescos y buena ventilación.',
      },
      'quinua': {
        'es': 'La quinua es un superalimento andino rico en proteínas, cultivado en zonas de altura y resistente a climas extremos.',
      },
    };

    return descriptions[name.toLowerCase()]?[language] ??
        'Información detallada próximamente disponible.';
  }
}
