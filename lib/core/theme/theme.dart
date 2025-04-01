import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
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
