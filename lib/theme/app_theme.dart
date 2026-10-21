import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MacTheme {
  static const Color accentBlue = Color(0xFF007AFF);
  static const Color darkGlass = Color(0xCC1E1E1E);
  static const Color lightGlass = Color(0xCCFFFFFF);
  static const Color darkBorder = Color(0x33FFFFFF);
  static const Color lightBorder = Color(0x33000000);

  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,
      colorScheme: const ColorScheme.dark(
        primary: accentBlue,
        surface: Color(0xFF1E1E1E),
        onSurface: Colors.white,
      ),
      textTheme: GoogleFonts.outfitTextTheme(ThemeData(brightness: Brightness.dark).textTheme),
    );
  }

  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF2F2F7),
      colorScheme: const ColorScheme.light(
        primary: accentBlue,
        surface: Colors.white,
        onSurface: Colors.black,
      ),
      textTheme: GoogleFonts.outfitTextTheme(ThemeData(brightness: Brightness.light).textTheme),
    );
  }
}
