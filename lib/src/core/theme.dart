import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatschat/src/core/colors.dart';

ThemeData appTheme() {
  return ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      elevation: 0,
    ),
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.fromSwatch(
      primaryColorDark: Colors.green[700],
      accentColor: AppColors.primary,
      backgroundColor: AppColors.background,
      cardColor: Colors.white,
      errorColor: Colors.red,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(),
  );
}
