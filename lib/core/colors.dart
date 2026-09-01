import 'dart:ui';

/// Central colour palette for the app. Kept as a singleton (referenced as
/// `ColorConstants.instance.<name>`) so a single edit here re-themes the whole
/// app.
///
/// Design System — modern Aegean / Mediterranean travel app:
///   Primary   #0D6EFD  Ege Mavisi (blue)
///   Secondary #E06D53  Terakota / gün batımı
///   Accent    #4A6B5D  Zeytin yeşili
///   Surface   #F8F9FA  Sıcak beyaz (background)
///   Card      #FFFFFF
///   Text main #1E293B  Slate 800
///   Text sub  #64748B  Slate 500
///
/// Historical field names (titleColor, activatedButton, ...) are preserved so
/// existing widgets keep working; they now point at the new palette. Semantic
/// tokens (sea, coral, olive, ink, mist, ...) drive the redesign.
class ColorConstants {
  static ColorConstants instance = ColorConstants._init();
  ColorConstants._init();

  // ---- New semantic palette ------------------------------------------------
  final sea = const Color(0xFF1A73E8); // Ege Mavisi — primary
  final seaDeep = const Color(0xFF0B2545); // deep navy — scrims / dark surfaces
  final seaMid = const Color(0xFF3B82F6); // lighter blue — secondary energy
  final coral = const Color(0xFFE06D53); // terakota / sunset — secondary accent
  final coralSoft = const Color(0xFFEC8A73);
  final olive = const Color(0xFF4A6B5D); // zeytin yeşili — natural accent
  final sunGold = const Color(0xFFFBBF24); // golden sun — sunset gradient start
  final sunset = const Color(0xFFF5771A); // warm orange — sunset gradient end / brand
  final salt = const Color(0xFFF8F9FA); // warm-white background
  final shell = const Color(0xFFFFFFFF); // card surface
  final ink = const Color(0xFF1E293B); // primary text — slate 800
  final mist = const Color(0xFF64748B); // secondary text — slate 500
  final gold = const Color(0xFFF5B301); // ratings only

  // ---- Legacy names (now mapped onto the new palette) ----------------------
  final activatedButton = const Color(0xFFE06D53); // -> coral
  final roomNumber = const Color(0xFFE06D53); // -> coral
  final starColor = const Color(0xFFF5B301); // -> gold
  final titleColor = const Color(0xFF1A73E8); // -> sea blue (functional chrome: back arrows, borders, inputs)
  final bottomBarIcon = const Color(0xFF1A73E8); // -> sea
  final commentColor = const Color(0xFF64748B); // -> mist
  final searcButtonColor = const Color(0xFF94A3B8); // slate 400
  final textFieldTextColor = const Color(0xFF64748B); // -> mist
  final lightGreyCardCollor = const Color(0xFFE2E8F0); // slate 200 — dividers
  final textFieldBacgroundColor = const Color(0xFFF1F5F9); // slate 100
  final imageFrontTextColor = const Color(0xFFFFFFFF);
}
