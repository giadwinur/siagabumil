import 'package:flutter/material.dart';
import 'package:siagabumil/dashboard/navdrawer.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool isWeeklyComplete = false;
  Map<String, bool> dailyStatus = {
    'Pagi': false,
    'Siang': false,
    'Malam': false,
    'Selingan Pagi': false,
    'Selingan Sore': false,
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Siaga Bumil'),
        backgroundColor: const Color(0xFFE91E63),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: NavDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Sambutan Full Width
            Container(
              width: double.infinity,
              height: 165,
              padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
              decoration: const BoxDecoration(color: Color(0xFFE91E63)),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Selamat Datang di \nSiAGA Bumil',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),

            // Bagian dengan padding dimulai dari sini
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),

                  // Status Pemantauan
                  const Text(
                    "Status Pemantauan",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFE91E63)),
                  ),
                  const SizedBox(height: 12),

                  Column(
                    children: [
                      // Card: Status Mingguan
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Status Mingguan:', style: TextStyle(fontWeight: FontWeight.w500)),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Icon(
                                    isWeeklyComplete ? Icons.check_circle : Icons.warning,
                                    color: isWeeklyComplete ? Colors.green : Colors.orange,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    isWeeklyComplete ? "Sudah Terpenuhi" : "Belum Terpenuhi",
                                    style: const TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Card: Status Harian
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Status Harian:', style: TextStyle(fontWeight: FontWeight.w500)),
                              const SizedBox(height: 12),
                              ...dailyStatus.entries.map(
                                (entry) => Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 2),
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: entry.value,
                                        onChanged: null,
                                        activeColor: const Color(0xFFE91E63),
                                      ),
                                      Text(entry.key),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Tips Kesehatan
                  const Text(
                    'Tips Kesehatan Ibu Hamil',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFE91E63)),
                  ),
                  const SizedBox(height: 12),

                  SizedBox(
                    height: 210,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 180,
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              child: const Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Icon(Icons.local_drink, size: 48, color: Color(0xFFE91E63)),
                                    SizedBox(height: 12),
                                    Text(
                                      'Minum air putih minimal 8 gelas per hari.',
                                      style: TextStyle(fontSize: 14),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          SizedBox(
                            width: 180,
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              child: const Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Icon(Icons.bedtime, size: 48, color: Color(0xFFE91E63)),
                                    SizedBox(height: 12),
                                    Text(
                                      'Istirahat cukup dan hindari stres.',
                                      style: TextStyle(fontSize: 14),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          SizedBox(
                            width: 180,
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              child: const Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Icon(Icons.apple, size: 48, color: Color(0xFFE91E63)),
                                    SizedBox(height: 12),
                                    Text(
                                      'Konsumsi buah dan sayur setiap hari.',
                                      style: TextStyle(fontSize: 14),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          SizedBox(
                            width: 180,
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              child: const Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Icon(Icons.medical_services, size: 48, color: Color(0xFFE91E63)),
                                    SizedBox(height: 12),
                                    Text(
                                      'Periksa kehamilan secara rutin.',
                                      style: TextStyle(fontSize: 14),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          SizedBox(
                            width: 180,
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              child: const Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Icon(Icons.directions_walk, size: 48, color: Color(0xFFE91E63)),
                                    SizedBox(height: 12),
                                    Text(
                                      'Lakukan olahraga ringan seperti jalan pagi.',
                                      style: TextStyle(fontSize: 14),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
