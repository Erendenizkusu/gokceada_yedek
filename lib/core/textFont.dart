import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gokceada/core/colors.dart';

/// Typographic scale for the app (referenced as `TextFonts.instance.<name>`).
///
/// Pairing: **Fraunces** (a characterful high-contrast serif) carries the
/// display/heading roles, giving the island guide a warm Mediterranean voice;
/// **Poppins** (already bundled) stays for body/UI text. Fraunces is served via
/// the `google_fonts` package (fetched and cached at runtime).
///
/// Legacy field names are preserved so existing widgets keep compiling; the
/// heading styles now render in Fraunces.
class TextFonts {
  static TextFonts instance = TextFonts._init();

  TextFonts._init();

  // ---- Display / heading roles — Fraunces ----------------------------------
  final appBarTitle = GoogleFonts.fraunces(
    fontSize: 24,
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );

  final appBarTitleColor = GoogleFonts.fraunces(
    fontSize: 24,
    color: ColorConstants.instance.sea,
    fontWeight: FontWeight.w600,
  );

  final titleFont = GoogleFonts.fraunces(
    color: ColorConstants.instance.sea,
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  final middleTitle = GoogleFonts.fraunces(
    fontSize: 21,
    color: ColorConstants.instance.ink,
    fontWeight: FontWeight.w600,
  );

  /// Compact section heading used above lists/carousels.
  final sectionTitle = GoogleFonts.fraunces(
    fontSize: 19,
    color: ColorConstants.instance.ink,
    fontWeight: FontWeight.w600,
  );

  /// Label drawn on top of images (category tiles, news cards).
  final imageFront = GoogleFonts.fraunces(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  // ---- Body / UI roles — Poppins -------------------------------------------
  final smallText = const TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w700,
    color: Colors.white,
    fontSize: 13.5,
  );

  /// Uppercase eyebrow / overline used above section titles.
  final eyebrow = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 11,
    letterSpacing: 1.8,
    fontWeight: FontWeight.w700,
    color: ColorConstants.instance.seaMid,
  );

  final commentTextBold = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18,
    color: ColorConstants.instance.commentColor,
    fontWeight: FontWeight.w600,
  );

  final explanationTextBold = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    color: ColorConstants.instance.mist,
    fontWeight: FontWeight.w400,
    height: 1.55,
  );

  final commentTextThin = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 15,
    color: ColorConstants.instance.commentColor,
    fontWeight: FontWeight.w300,
  );

  final priceFont = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w700,
    fontSize: 22,
    color: ColorConstants.instance.sea,
  );

  final underlineFont = TextStyle(
    fontFamily: 'Poppins',
    color: ColorConstants.instance.coral,
    decoration: TextDecoration.underline,
    decorationColor: ColorConstants.instance.coral,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );

  final imageFrontRating = const TextStyle(
    fontFamily: 'Montserrat',
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  final middleWhiteColor = const TextStyle(
    fontFamily: 'Montserrat',
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );
}
