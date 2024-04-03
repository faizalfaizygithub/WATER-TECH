import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle get headingStyle {
  return GoogleFonts.aBeeZee(
      textStyle: const TextStyle(
    fontWeight: FontWeight.w600,
  ));
}

TextStyle get BheadingStyle {
  return GoogleFonts.aBeeZee(
      textStyle: const TextStyle(
          fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold));
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(fontSize: 12, color: Colors.grey.shade500));
}

TextStyle get buttonStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold));
}

TextStyle get smalltext {
  return GoogleFonts.lato(
      textStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.w500));
}
