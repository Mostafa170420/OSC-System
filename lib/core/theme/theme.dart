import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    dialogBackgroundColor: Color(0xFF212332),
    drawerTheme: DrawerThemeData(backgroundColor: Color(0xFF2A2D3E)),
    canvasColor: Color(0xFF2A2D3E),
    primaryColor: Color(0xfffcad08),
    scaffoldBackgroundColor: Color(0xFF212332),
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
