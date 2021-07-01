import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  static TextStyle get defaultStyle => GoogleFonts.montserrat(
        fontSize: 20,
        color: Colors.white,
        decoration: TextDecoration.none,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get debug => TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.normal,
        decoration: TextDecoration.none,
        color: Colors.black,
      );

}




TextStyle pop(TextStyle style) {
  return style.copyWith(
      shadows: [
        Shadow(color: Colors.black26, offset: Offset(2, 2), blurRadius: 1.5),
      ]
  );
}
