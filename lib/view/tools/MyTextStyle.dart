import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle get BlueheadingStyle {
  return GoogleFonts.aBeeZee(
      textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.blue.shade800));
}

TextStyle get WhiteheadingStyle {
  return GoogleFonts.aBeeZee(
      textStyle: const TextStyle(
          fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold));
}

TextStyle get greySmalltext {
  return GoogleFonts.lato(
      textStyle: TextStyle(fontSize: 12, color: Colors.grey.shade600));
}

TextStyle get whiteSmalltext {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 12,
    color: Colors.white70,
  ));
}

TextStyle get subHeadingStyleBlue {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.blue.shade700));
}

TextStyle get buttonStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold));
}

TextStyle get blacksmalltext {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 10, color: Colors.black, fontWeight: FontWeight.w500));
}

TextStyle get blacktextStyle {
  return GoogleFonts.aBeeZee(
      textStyle:
          const TextStyle(color: Colors.black54, fontWeight: FontWeight.w600));
}
