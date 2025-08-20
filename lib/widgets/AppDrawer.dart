import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/LoginScreen.dart';
import '../screens/HomeScreen.dart';
import '../screens/ViewPetsScreen.dart';
import '../screens/RescueRequestScreen.dart';
import '../screens/GalleryScreen.dart';
import '../screens/OurWorkScreen.dart';
import '../screens/VeterinaryScreen.dart';
import '../screens/VaccineScreen.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String userName = '';
  String userEmail = '';

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('name') ?? 'Guest';
      userEmail = prefs.getString('email') ?? '';
    });
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 32),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00897B), Color(0xFF00695C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage(
                    'assets/images/user.png',
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  userEmail,
                  style: const TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _buildTile(Icons.home, 'Home', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                  );
                }),
                _buildTile(Icons.pets, 'View Pets', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ViewPetsScreen()),
                  );
                }),
                _buildTile(Icons.report, 'Rescue Request', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const RescueRequestScreen(),
                    ),
                  );
                }),
                _buildTile(Icons.photo_album, 'Gallery', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const GalleryScreen()),
                  );
                }),
                _buildTile(Icons.work, 'Our Work', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const OurWorkScreen()),
                  );
                }),
                _buildTile(Icons.vaccines, 'Vaccine', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const VaccineScreen()),
                  );
                }),
                _buildTile(Icons.local_hospital, 'Veterinary', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const VeterinaryScreen()),
                  );
                }),
              ],
            ),
          ),

          // Logout Button with SafeArea and full width
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _logout,
                  icon: const Icon(Icons.logout, color: Colors.white),
                  label: const Text(
                    "Logout",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    shadowColor: Colors.redAccent,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTile(IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.teal.shade700),
      title: Text(
        label,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      hoverColor: Colors.teal.shade50,
    );
  }
}
