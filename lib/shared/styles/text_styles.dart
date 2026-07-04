import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/shared/components/constants.dart';
import 'package:todo/shared/styles/app_colors.dart';

class AppStyles {
  static TextStyle poppins22White() => GoogleFonts.poppins(
    fontSize: AppConstants.bodyLargeFontSize,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle poppins22Black() => GoogleFonts.poppins(
    fontSize: AppConstants.bodyLargeFontSize,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle poppins18Primary() => GoogleFonts.poppins(
    fontSize: AppConstants.bodyMedFontSize,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryColor,
  );

  static TextStyle poppins18Black() => GoogleFonts.poppins(
    fontSize: AppConstants.bodyMedFontSize,
    fontWeight: FontWeight.w300,
    color: Colors.black,
  );

  static TextStyle roboto12Black() => GoogleFonts.roboto(
    fontSize: AppConstants.bodySmallFontSize,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

  static TextStyle roboto12White() => GoogleFonts.roboto(
    fontSize: AppConstants.bodySmallFontSize,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );
}
