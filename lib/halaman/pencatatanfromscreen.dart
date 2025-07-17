import 'package:flutter/material.dart';

class PencatatanFormScreen extends StatefulWidget {
  final int trimester;

  const PencatatanFormScreen({super.key, required this.trimester});

  @override
  // ignore: library_private_types_in_public_api
  _PencatatanFormScreenState createState() => _PencatatanFormScreenState();
}

class _PencatatanFormScreenState extends State<PencatatanFormScreen> {
  String _selectedKategori = 'Makanan Utama';
  String _selectedWaktu = 'Pagi';
  String? _selectedBahan;
  final TextEditingController _ukuranController = TextEditingController();
  String _satuan = 'gram';

  final List<String> _kategoriOptions = ['Makanan Utama', 'Selingan'];
  final List<String> _waktuUtamaOptions = ['Pagi', 'Siang', 'Malam'];
  final List<String> _waktuSelinganOptions = ['Pagi', 'Sore'];

  // Data dummy bahan makanan
  final List<Map<String, dynamic>> _bahanMakanan = [
    {'nama': 'Nasi putih', 'satuan': 'gram'},
    {'nama': 'Ayam goreng', 'satuan': 'potong'},
    {'nama': 'Ikan bakar', 'satuan': 'potong'},
    {'nama': 'Tempe goreng', 'satuan': 'potong'},
    {'nama': 'Sayur bayam', 'satuan': 'mangkuk'},
    {'nama': 'Wortel', 'satuan': 'gram'},
    {'nama': 'Pisang', 'satuan': 'buah'},
    {'nama': 'Apel', 'satuan': 'buah'},
    {'nama': 'Susu UHT', 'satuan': 'gelas'},
    {'nama': 'Roti tawar', 'satuan': 'lembar'},
  ];

  final List<Map<String, dynamic>> _konsumsiList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pencatatan Makanan'),
        backgroundColor: const Color(0xFFE91E63),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.pink[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Trimester ${widget.trimester}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink[800],
                      ),
                    ),
                    Text(
                      'Isi pencatatan makanan Anda',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Form Input
              _buildSectionTitle('Kategori Makanan'),
              _buildKategoriSelector(),

              const SizedBox(height: 16),

              _buildSectionTitle('Waktu Makan'),
              _buildWaktuSelector(),

              const SizedBox(height: 16),

              _buildSectionTitle('Bahan Makanan'),
              _buildBahanDropdown(),

              const SizedBox(height: 16),

              _buildSectionTitle('Ukuran'),
              _buildUkuranInput(),

              const SizedBox(height: 24),

              // Tombol Tambah
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _addToKonsumsi,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[400],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Tambah ke Konsumsi',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Rekapan Konsumsi
              if (_konsumsiList.isNotEmpty) ...[
                _buildSectionTitle('Rekapan Konsumsi'),
                _buildKonsumsiList(),

                const SizedBox(height: 24),

                // Tombol Simpan
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveKonsumsi,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[600],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Simpan Pencatatan',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.pink[800],
        ),
      ),
    );
  }

  Widget _buildKategoriSelector() {
    return Row(
      children: _kategoriOptions.map((kategori) {
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: kategori == _kategoriOptions.last ? 0 : 8),
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedKategori = kategori;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _selectedKategori == kategori ? Colors.pink[400] : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    kategori,
                    style: TextStyle(
                      color: _selectedKategori == kategori ? Colors.white : Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildWaktuSelector() {
    List<String> waktuOptions = _selectedKategori == 'Makanan Utama' ? _waktuUtamaOptions : _waktuSelinganOptions;

    return Wrap(
      spacing: 8,
      children: waktuOptions.map((waktu) {
        return InkWell(
          onTap: () {
            setState(() {
              _selectedWaktu = waktu;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: _selectedWaktu == waktu ? Colors.pink[400] : Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              waktu,
              style: TextStyle(
                color: _selectedWaktu == waktu ? Colors.white : Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBahanDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: _selectedBahan,
        hint: const Text('Pilih bahan makanan'),
        isExpanded: true,
        underline: const SizedBox(),
        items: _bahanMakanan.map((bahan) {
          return DropdownMenuItem<String>(
            value: bahan['nama'],
            child: Text(bahan['nama']),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedBahan = value;
            // Update satuan berdasarkan bahan yang dipilih
            final selectedItem = _bahanMakanan.firstWhere(
              (bahan) => bahan['nama'] == value,
              orElse: () => {'satuan': 'gram'},
            );
            _satuan = selectedItem['satuan'];
          });
        },
      ),
    );
  }

  Widget _buildUkuranInput() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: TextField(
            controller: _ukuranController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Masukkan ukuran',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Text(
              _satuan,
              style: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildKonsumsiList() {
    return Column(
      children: _konsumsiList.map((item) {
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
                      item['bahan'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${item['kategori']} ${item['waktu']} - ${item['ukuran']} ${item['satuan']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _konsumsiList.remove(item);
                  });
                },
                icon: Icon(Icons.delete, color: Colors.red[400], size: 20),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  void _addToKonsumsi() {
    if (_selectedBahan != null && _ukuranController.text.isNotEmpty) {
      setState(() {
        _konsumsiList.add({
          'kategori': _selectedKategori,
          'waktu': _selectedWaktu,
          'bahan': _selectedBahan!,
          'ukuran': _ukuranController.text,
          'satuan': _satuan,
        });
      });

      // Reset form
      _selectedBahan = null;
      _ukuranController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Berhasil ditambahkan ke konsumsi'),
          backgroundColor: Colors.green[600],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Mohon lengkapi bahan makanan dan ukuran'),
          backgroundColor: Colors.red[600],
        ),
      );
    }
  }

  void _saveKonsumsi() {
    // Implementasi penyimpanan ke database
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Pencatatan berhasil disimpan'),
        backgroundColor: Colors.green[600],
      ),
    );

    // Kembali ke halaman sebelumnya
    Navigator.pop(context);
  }
}
