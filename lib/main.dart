import 'package:flutter/material.dart';
import 'package:pawconnect/screens/DonationScreen.dart';
import 'package:pawconnect/screens/GalleryScreen.dart';
import 'package:pawconnect/screens/RescueRequestScreen.dart';
import 'package:pawconnect/screens/VaccineScreen.dart';
import 'package:pawconnect/screens/VeterinaryScreen.dart';
import 'package:pawconnect/screens/VolunteerScreen.dart';
import 'screens/SplashScreen.dart';
import 'screens/LoginScreen.dart';
import 'screens/RegisterScreen.dart';
import 'screens/HomeScreen.dart';
import 'screens/ViewPetsScreen.dart'; // Add other screens as needed

void main() {
  runApp(const PawConnectApp());
}

class PawConnectApp extends StatelessWidget {
  const PawConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PawConnect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF008080),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF008080),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF008080),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black87),
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF008080),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF008080)),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/view-pets': (context) => const ViewPetsScreen(), 
        '/rescue-request': (context) => const RescueRequestScreen(),
        '/gallery': (context) => const GalleryScreen(),
        '/donate': (context) => const DonationScreen(),
        '/volunteer': (context) => const BecomeVolunteerScreen(),
        '/vaccine': (context) => const VaccineScreen(),
        '/veterinary': (context) => const VeterinaryScreen(),

      },
    );
  }
}
