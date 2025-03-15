import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.amber,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.amber,
      foregroundColor: Colors.black,
    ),
    textTheme: TextTheme(
      headlineSmall: TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.black),
    ),
    drawerTheme: DrawerThemeData(backgroundColor: Colors.white),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    drawerTheme: DrawerThemeData(backgroundColor: Color(0xFF111111)),
    canvasColor: Color(0xFF111111),
    primaryColor: Color(0xfffcad08),
    scaffoldBackgroundColor: Color(0xFF1f1f1f),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
    ),
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
        )),
  );
}
