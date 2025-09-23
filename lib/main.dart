// lib/main.dart

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bukuku/pages/login_page.dart';
import 'firebase_options.dart';

const Color primaryColor = Color(0xFFF5F5F5);
const Color secondaryColor = Color(0xFF4A90E2);
const Color textColor = Color(0xFF333333);
const Color accentColor = Color(0xFF7EC8E3);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BukuKu',
      theme: ThemeData(
        // Tema terang (light theme)
        brightness: Brightness.light,
        scaffoldBackgroundColor: primaryColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: textColor,
          elevation: 0, // Hilangkan bayangan untuk kesan modern
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: textColor),
          bodyLarge: TextStyle(color: textColor),
          titleMedium: TextStyle(color: textColor),
          titleLarge: TextStyle(color: textColor),
        ),
        // Skema warna untuk widget interaktif
        colorScheme: const ColorScheme.light(
          primary: secondaryColor, // Tombol, indikator aktif
          secondary: accentColor, // Tombol Aksi, aksen
          onPrimary: Colors.white,
          onSecondary: textColor,
          surface: primaryColor,
          background: primaryColor,
          onSurface: textColor,
          onBackground: textColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: secondaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 2,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFFE0E0E0), // Abu-abu terang untuk bidang input
          labelStyle: TextStyle(color: textColor),
          hintStyle: TextStyle(color: Color(0xFF888888)), // Abu-abu sedikit lebih gelap
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: secondaryColor, width: 2),
          ),
        ),
      ),
      home: const LoginPage(),
    );
  }
}