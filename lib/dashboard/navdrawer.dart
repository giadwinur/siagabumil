import 'package:flutter/material.dart';

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  String userName = 'Nama Pengguna';
  String userImage = '';

  @override
  void initState() {
    super.initState();
    // _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFE91E63), Color(0xFFAD1457)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User Photo
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: userImage.isNotEmpty
                      ? ClipOval(
                          child: Image.network(
                            userImage,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.person, size: 40, color: Color(0xFFE91E63));
                            },
                          ),
                        )
                      : const Icon(Icons.person, size: 40, color: Color(0xFFE91E63)),
                ),
                const SizedBox(height: 16),
                // App Name
                const Text(
                  'SiAGA Bumil',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                // User Name
                Text(userName, style: const TextStyle(color: Colors.white70, fontSize: 16)),
              ],
            ),
          ),

          // Menu Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  icon: Icons.home,
                  title: 'Beranda',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/DashboardPage');
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.person,
                  title: 'Biodata',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/BiodataScreens');
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.school,
                  title: 'Edukasi',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/EdukasiScreen');
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.chat,
                  title: 'Konsultasi AI',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/KonsultasiScreen');
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.restaurant,
                  title: 'Pencatatan Makanan',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/PencatatanScreen');
                  },
                ),
                const Divider(),
                // _buildDrawerItem(
                //   icon: Icons.settings,
                //   title: 'Pengaturan',
                //   onTap: () {
                //     Navigator.pop(context);
                //     // TODO: Implement settings
                //   },
                // ),
                // _buildDrawerItem(
                //   icon: Icons.info,
                //   title: 'Tentang',
                //   onTap: () {
                //     Navigator.pop(context);
                //     _showAboutDialog();
                //   },
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFE91E63)),
      title: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      onTap: onTap,
      dense: true,
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tentang Siaga Bumil'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Siaga Bumil - Sistem Asupan Gizi dan AI untuk Bumil'),
              SizedBox(height: 8),
              Text('Versi 1.0.0'),
              SizedBox(height: 8),
              Text('Aplikasi untuk membantu ibu hamil dalam memantau asupan gizi dan mendapatkan konsultasi AI.'),
            ],
          ),
          actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Tutup'))],
        );
      },
    );
  }
}
