import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../widgets/AppDrawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<String> sliderImages = const [
    'assets/images/slider1.png',
    'assets/images/slider2.png',
    'assets/images/slider3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("PawConnect"),
        backgroundColor: Colors.teal.shade700,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Background with custom shapes
          Positioned(
            top: -100,
            left: -80,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.teal.shade100,
                borderRadius: BorderRadius.circular(200),
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(150),
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // 🖼 Carousel
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 190.0,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 0.9,
                    ),
                    items: sliderImages.map((imagePath) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 20),

                  // Title & Typing
                  const Text(
                    'Welcome to PawConnect!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText(
                        'Rescue. Rehabilitate. Rehome.',
                        textStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontStyle: FontStyle.italic,
                        ),
                        speed: Duration(milliseconds: 70),
                      ),
                    ],
                    totalRepeatCount: 1,
                  ),

                  const SizedBox(height: 30),

                  // Feature Buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Wrap(
                      spacing: 14,
                      runSpacing: 14,
                      children: [
                        _buildHomeCard(
                          icon: Icons.pets,
                          label: 'View Pets',
                          onTap: () =>
                              Navigator.pushNamed(context, '/view-pets'),
                        ),
                        _buildHomeCard(
                          icon: Icons.medical_services,
                          label: 'Rescue',
                          onTap: () =>
                              Navigator.pushNamed(context, '/rescue-request'),
                        ),
                        _buildHomeCard(
                          icon: Icons.photo_album,
                          label: 'Gallery',
                          onTap: () => Navigator.pushNamed(context, '/gallery'),
                        ),
                        _buildHomeCard(
                          icon: Icons.volunteer_activism,
                          label: 'Donate',
                          onTap: () => Navigator.pushNamed(context, '/donate'),
                        ),
                        _buildHomeCard(
                          icon: Icons.vaccines,
                          label: 'Vaccine',
                          onTap: () => Navigator.pushNamed(context, '/vaccine'),
                        ),
                        _buildHomeCard(
                          icon: Icons.local_hospital,
                          label: 'Veterinary',
                          onTap: () =>
                              Navigator.pushNamed(context, '/veterinary'),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Volunteer CTA
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.teal.shade50,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.handshake,
                                size: 36,
                                color: Colors.teal,
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Become a Volunteer',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Join us to help rescue and care for animals in need.\nMake a real difference!',
                            style: TextStyle(color: Colors.black87),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: () =>
                                Navigator.pushNamed(context, '/volunteer'),
                            icon: const Icon(Icons.group_add),
                            label: const Text('Join Now'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 14,
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
          ),
        ],
      ),
    );
  }

  Widget _buildHomeCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: 150,
      height: 65,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, color: Colors.white, size: 22),
        label: Text(
          label,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal.shade600,
          foregroundColor: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}
