import 'package:flutter/material.dart';
import 'package:siagabumil/dashboard/dashboard.dart';
import 'package:siagabumil/halaman/biodata.dart';
import 'package:siagabumil/halaman/edukasi.dart';
import 'package:siagabumil/halaman/konsultasi.dart';
import 'package:siagabumil/halaman/pencatatanMakanan.dart';
import 'package:siagabumil/page/welcome.page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Siaga Bumil',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.pink),
      home: const WelcomePage(), // <- inilah halaman awalnya
      routes: {
        '/DashboardPage': (context) => const DashboardPage(),
        '/BiodataScreens': (context) => const BiodataScreen(),
        '/EdukasiScreen': (context) => const EdukasiScreen(),
        '/KonsultasiScreen': (context) => const KonsultasiScreen(),
        '/PencatatanScreen': (context) => const PencatatanScreen(),
      },
    );
  }
}
