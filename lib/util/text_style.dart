import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonTextStyle {
  static TextStyle appBarTextStyle = GoogleFonts.poppins(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static TextStyle detailsTextStyle = GoogleFonts.poppins();
  static TextStyle detailsWithLineThroughTextStyle =
      GoogleFonts.poppins(decoration: TextDecoration.lineThrough);
  static TextStyle titleTextStyle =
      GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18);
  static TextStyle titleTextWithLineThroughStyle = GoogleFonts.poppins(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      decoration: TextDecoration.lineThrough);
  static TextStyle levelTextStyle = GoogleFonts.poppins(
      color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold);
  static TextStyle buttonTextStyle = GoogleFonts.poppins(
      color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold);
}
