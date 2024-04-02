import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle get headingStyle {
  return GoogleFonts.aBeeZee(
      textStyle: const TextStyle(
    fontWeight: FontWeight.w600,
  ));
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(fontSize: 12, color: Colors.grey.shade500));
}

TextStyle get buttonStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold));
}
