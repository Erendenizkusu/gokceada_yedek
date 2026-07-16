import 'dart:ui';

/// Central colour palette for the app. Kept as a singleton (referenced as
/// `ColorConstants.instance.<name>`) so a single edit here re-themes the whole
/// app.
///
/// Design direction — "Deniz, tuz, zeytin, gün batımı": a vivid Aegean-island
/// identity. Deep sea teal leads, a brighter turquoise energises, and a single
/// vibrant sunset coral is the one accent (active states, tags, primary
/// actions). Olive is the natural secondary; gold stays for ratings only.
///
/// The historical field names (titleColor, activatedButton, ...) are preserved
/// so existing widgets keep working; they now point at the new palette. New
/// semantic tokens (sea, coral, olive, ...) are added for the redesign.
class ColorConstants {
  static ColorConstants instance = ColorConstants._init();
  ColorConstants._init();

  // ---- New semantic palette ------------------------------------------------
  final sea = const Color(0xFF0E4C57); // deep Aegean teal — primary
  final seaDeep = const Color(0xFF0A3A43); // darker teal — app bar, scrims
  final seaMid = const Color(0xFF1B8A9C); // bright turquoise — secondary/energy
  final coral = const Color(0xFFF26430); // vivid sunset — the single accent
  final coralSoft = const Color(0xFFF8875A);
  final olive = const Color(0xFF8A9A4B); // olive leaf — natural secondary
  final salt = const Color(0xFFEFF3F2); // salt-white background
  final shell = const Color(0xFFFFFFFF); // card surface
  final ink = const Color(0xFF16292B); // primary text (deep sea shadow)
  final mist = const Color(0xFF6E8683); // muted secondary text
  final gold = const Color(0xFFF5B301); // ratings only

  // ---- Legacy names (now mapped onto the new palette) ----------------------
  final activatedButton = const Color(0xFFF26430); // -> coral
  final roomNumber = const Color(0xFFF26430); // -> coral
  final starColor = const Color(0xFFF5B301); // -> gold
  final titleColor = const Color(0xFF0E4C57); // -> sea (primary text/app bar)
  final bottomBarIcon = const Color(0xFF0E4C57); // -> sea
  final commentColor = const Color(0xFF6E8683); // -> mist
  final searcButtonColor = const Color(0xFFA9BEBB);
  final textFieldTextColor = const Color(0xFF6E8683);
  final lightGreyCardCollor = const Color(0xFFE4EBE9);
  final textFieldBacgroundColor = const Color(0xFFF4F7F6);
  final imageFrontTextColor = const Color(0xFFFFFFFF);
}
