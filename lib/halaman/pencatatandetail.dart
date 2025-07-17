import 'package:flutter/material.dart';

class PencatatanDetailScreen extends StatelessWidget {
  final String tanggal;
  final String hari;
  final int trimester;

  PencatatanDetailScreen({
    super.key,
    required this.tanggal,
    required this.hari,
    required this.trimester,
  });

  // Data dummy untuk demo
  final List<Map<String, dynamic>> _detailData = [
    {
      'kategori': 'Makanan Utama Pagi',
      'waktu': '07:30',
      'makanan': [
        {'nama': 'Nasi putih', 'jumlah': '1 piring', 'kalori': '150 kcal'},
        {'nama': 'Ayam goreng', 'jumlah': '1 potong', 'kalori': '250 kcal'},
        {'nama': 'Sayur bayam', 'jumlah': '1 mangkuk', 'kalori': '30 kcal'},
      ],
    },
    {
      'kategori': 'Selingan Pagi',
      'waktu': '10:00',
      'makanan': [
        {'nama': 'Pisang', 'jumlah': '1 buah', 'kalori': '95 kcal'},
        {'nama': 'Susu UHT', 'jumlah': '1 gelas', 'kalori': '150 kcal'},
      ],
    },
    {
      'kategori': 'Makanan Utama Siang',
      'waktu': '12:30',
      'makanan': [
        {'nama': 'Nasi putih', 'jumlah': '1 piring', 'kalori': '150 kcal'},
        {'nama': 'Ikan bakar', 'jumlah': '1 potong', 'kalori': '200 kcal'},
        {'nama': 'Tempe goreng', 'jumlah': '2 potong', 'kalori': '160 kcal'},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pencatatan'),
        backgroundColor: const Color(0xFFE91E63),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Info
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.pink[50],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$hari, $tanggal',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink[800],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Trimester $trimester',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.pink[600],
                    ),
                  ),
                ],
              ),
            ),

            // Detail Pencatatan
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rincian Pencatatan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink[800],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // List Detail per Kategori
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _detailData.length,
                    itemBuilder: (context, index) {
                      return _buildDetailCard(_detailData[index]);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard(Map<String, dynamic> data) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data['kategori'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink[800],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.pink[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    data['waktu'],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.pink[700],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Daftar Makanan
            Column(
              children: data['makanan'].map<Widget>((makanan) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              makanan['nama'],
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              makanan['jumlah'],
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        makanan['kalori'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.pink[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
