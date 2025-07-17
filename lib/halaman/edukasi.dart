import 'package:flutter/material.dart';

class EdukasiScreen extends StatefulWidget {
  const EdukasiScreen({super.key});

  @override
  State<EdukasiScreen> createState() => _EdukasiScreenState();
}

class _EdukasiScreenState extends State<EdukasiScreen> {
  List<String> categories = [
    'Semua',
    'Nutrisi',
    'Laktasi',
    'Perawatan Bayi',
    'kesehatann Fisik & Mental Ibu',
    'Vitamin & Suplemen',
    'Pantangan & Mitos',
    'Trimester',
  ];
  String selectedCategory = 'Semua';
  TextEditingController searchController = TextEditingController();
  bool isConnected = true;
  bool isLoading = true;

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edukasi'),
        backgroundColor: const Color(0xFFE91E63),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          if (!isConnected)
            Container(
              width: double.infinity,
              color: Colors.orange,
              padding: const EdgeInsets.all(8),
              child: const Row(
                children: [
                  Icon(Icons.warning, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'Tidak ada koneksi internet. Silakan hubungkan ke internet.',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          // Search and Filter
          if (isConnected)
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Search Bar
                  TextField(
                    controller: searchController,
                    // onChanged: (value) => _filterArticles(),
                    decoration: InputDecoration(
                      hintText: 'Cari artikel...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Category Filter
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        final isSelected = selectedCategory == category;

                        return Container(
                          margin: const EdgeInsets.only(right: 8),
                          child: FilterChip(
                            label: Text(category),
                            selected: isSelected,
                            onSelected: (bool selected) {
                              setState(() {
                                selectedCategory = category;
                              });
                              // _filterArticles();
                            },
                            backgroundColor: Colors.grey[200],
                            selectedColor: const Color(0xFFE91E63),
                            labelStyle: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

          // Articles List
          Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : !isConnected
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.wifi_off,
                                size: 60,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Tidak menemukan artikel',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                'Pastikan koneksi internet aktif',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )
                      :
                      // :
                      // filteredArticles.isEmpty
                      //     ?
                      const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.article,
                                size: 60,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Tidak ada artikel ditemukan',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )
              // : ListView.builder(
              //     padding: const EdgeInsets.all(16),
              //     // itemCount: filteredArticles.length,
              //     itemBuilder: (context, index) {
              //       // final article = filteredArticles[index];
              //       // return _buildArticleCard(article);
              //     },
              //   ),
              ),
        ],
      ),
    );
  }
}
