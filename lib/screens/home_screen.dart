import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../localization/app_localizations.dart';
import '../widgets/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  final String languageCode;
  final void Function(String) onLanguageSelected;

  const HomeScreen({
    super.key,
    required this.languageCode,
    required this.onLanguageSelected,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations(languageCode);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.getText('title'),
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color(0xFF1D4576),
      ),
      drawer: AppDrawer(
        languageCode: languageCode,
        onLanguageSelected: onLanguageSelected,
      ),
      body: StreamBuilder<QuerySnapshot>(
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
                margin: const EdgeInsets.all(12),
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
      backgroundColor: const Color(0xFFF6F3E8),
    );
  }
}
