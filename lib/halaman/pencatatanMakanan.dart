// lib/screens/pencatatan_makanan/trimester_selection_screen.dart
import 'package:flutter/material.dart';
import 'package:siagabumil/halaman/pencatatanlist.dart';

class PencatatanScreen extends StatelessWidget {
  const PencatatanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pencatatan Makanan'),
        backgroundColor: const Color(0xFFE91E63),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pilih Trimester Kehamilan',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.pink[800]),
            ),
            const SizedBox(height: 8),
            Text(
              'Silakan pilih trimester kehamilan Anda untuk melanjutkan pencatatan makanan',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: ListView(
                children: [
                  _buildTrimesterCard(
                    context,
                    'Trimester I',
                    '0-12 Minggu',
                    'Periode awal kehamilan dengan fokus pada asam folat dan vitamin B',
                    Icons.pregnant_woman,
                    Colors.pink[100]!,
                    1,
                  ),
                  const SizedBox(height: 16),
                  _buildTrimesterCard(
                    context,
                    'Trimester II',
                    '13-27 Minggu',
                    'Periode pertumbuhan janin dengan kebutuhan protein dan kalsium',
                    Icons.favorite,
                    Colors.pink[200]!,
                    2,
                  ),
                  const SizedBox(height: 16),
                  _buildTrimesterCard(
                    context,
                    'Trimester III',
                    '28-40 Minggu',
                    'Periode persiapan persalinan dengan kebutuhan zat besi tinggi',
                    Icons.child_care,
                    Colors.pink[300]!,
                    3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrimesterCard(
    BuildContext context,
    String title,
    String period,
    String description,
    IconData icon,
    Color color,
    int trimester,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => PencatatanListScreen(trimester: trimester)));
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [color.withOpacity(0.3), color.withOpacity(0.1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.pink[800]),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      period,
                      style: TextStyle(fontSize: 14, color: Colors.pink[600], fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    Text(description, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.pink[400], size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
