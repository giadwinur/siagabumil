// lib/screens/pencatatan_makanan/pencatatan_list_screen.dart
import 'package:flutter/material.dart';
import 'package:siagabumil/halaman/pencatatandetail.dart';
import 'package:siagabumil/halaman/pencatatanfromscreen.dart';

class PencatatanListScreen extends StatefulWidget {
  final int trimester;

  const PencatatanListScreen({super.key, required this.trimester});

  @override
  // ignore: library_private_types_in_public_api
  _PencatatanListScreenState createState() => _PencatatanListScreenState();
}

class _PencatatanListScreenState extends State<PencatatanListScreen> {
  final TextEditingController _searchController = TextEditingController();
  // ignore: unused_field
  String _searchQuery = '';

  // Data dummy untuk demo
  final List<Map<String, dynamic>> _pencatatanData = [
    {
      'tanggal': '16 Juli 2025',
      'hari': 'Rabu',
      'kategori': ['Makanan Utama Pagi', 'Selingan Pagi', 'Makanan Utama Siang'],
      'completed': 3,
      'total': 5,
    },
    {
      'tanggal': '15 Juli 2025',
      'hari': 'Selasa',
      'kategori': [
        'Makanan Utama Pagi',
        'Selingan Pagi',
        'Makanan Utama Siang',
        'Selingan Sore',
        'Makanan Utama Malam',
      ],
      'completed': 5,
      'total': 5,
    },
    {
      'tanggal': '14 Juli 2025',
      'hari': 'Senin',
      'kategori': ['Makanan Utama Pagi', 'Makanan Utama Siang'],
      'completed': 2,
      'total': 5,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pencatatan Trimester ${widget.trimester}'),
        backgroundColor: const Color(0xFFE91E63),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.pink[50],
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari berdasarkan tanggal atau kategori...',
                prefixIcon: Icon(Icons.search, color: Colors.pink[400]),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),

          // List Pencatatan
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _pencatatanData.length,
              itemBuilder: (context, index) {
                final data = _pencatatanData[index];
                return _buildPencatatanCard(data);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PencatatanFormScreen(trimester: widget.trimester)),
          );
        },
        backgroundColor: Colors.pink[400],
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildPencatatanCard(Map<String, dynamic> data) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PencatatanDetailScreen(tanggal: data['tanggal'], hari: data['hari'], trimester: widget.trimester),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['hari'],
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.pink[800]),
                      ),
                      Text(data['tanggal'], style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: data['completed'] == data['total'] ? Colors.green[100] : Colors.orange[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${data['completed']}/${data['total']}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: data['completed'] == data['total'] ? Colors.green[800] : Colors.orange[800],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Kategori Tercatat:',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey[700]),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: data['kategori'].map<Widget>((kategori) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.pink[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.pink[200]!),
                    ),
                    child: Text(kategori, style: TextStyle(fontSize: 12, color: Colors.pink[700])),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
