import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    primaryColor: Colors.amber,
    scaffoldBackgroundColor: Color(0xFFF5F5F5),
    cardColor: Color(0xFFE0E0E0),
    drawerTheme: DrawerThemeData(backgroundColor: Color(0xFFD6D6D6)),
    dialogBackgroundColor: Color(0xFFE8E8E8),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black87,
    ),
    iconTheme: IconThemeData(
      color: Colors.black87, // Dark icons for light theme
      size: 24,
    ),
    hoverColor: Colors.amber.withOpacity(0.2), // Hover effect for light theme
    textTheme: TextTheme(
      labelMedium: GoogleFonts.nunito(
        fontWeight: FontWeight.w700,
        fontSize: 20,
        color: Colors.black87,
      ),
      labelSmall: GoogleFonts.nunito(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: Colors.black87,
      ),
      titleLarge: GoogleFonts.nunito(
        fontWeight: FontWeight.w600,
        fontSize: 30,
        color: Colors.black,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    cardColor: Color(0xff1a1a1a),
    useMaterial3: true,
    dialogBackgroundColor: Color(0xFF2a2a2a),
    drawerTheme: DrawerThemeData(backgroundColor: Color(0xFF2c2c2c)),
    canvasColor: Color(0xFF2c2c2c),
    primaryColor: Color(0xfffcad08),
    scaffoldBackgroundColor: Color(0xFF1f1f1f),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
    ),
    iconTheme: IconThemeData(
      color: Colors.grey[300], // Light icons for dark theme
      size: 24,
    ),
    hoverColor: Colors.orange.withOpacity(0.3), // Hover effect for dark theme
    textTheme: TextTheme(
      labelMedium: GoogleFonts.nunito(
        fontWeight: FontWeight.w700,
        fontSize: 20,
        color: Colors.grey[300],
      ),
      labelSmall: GoogleFonts.nunito(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: Colors.grey[300],
      ),
      titleLarge: GoogleFonts.nunito(
        fontWeight: FontWeight.w600,
        fontSize: 30,
        color: Colors.white,
      ),
    ),
  );
}
