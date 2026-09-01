import 'package:flutter/material.dart';
import 'package:gokceada/core/colors.dart';

/// Typographic scale for the app (referenced as `TextFonts.instance.<name>`).
///
/// The app's original ("göz bebeği") UI used **Poppins** — a clean, geometric,
/// Google-Sans-flavoured face. Poppins is **bundled as an asset** in
/// `pubspec.yaml` (`assets/fonts/Poppins-Regular.ttf` + `-Bold.ttf`), so the
/// whole scale below uses `fontFamily: 'Poppins'` directly. This guarantees the
/// correct face offline and instantly — unlike `google_fonts`, which fetches
/// over the network and silently falls back to the system font (Roboto) when
/// the download fails, which is exactly what made earlier builds look wrong.
class TextFonts {
  static TextFonts instance = TextFonts._init();

  TextFonts._init();

  static const String _family = 'Poppins';

  // ---- Display / heading roles ---------------------------------------------
  final appBarTitle = const TextStyle(
    fontFamily: _family,
    fontSize: 22,
    color: Colors.white,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
  );

  final appBarTitleColor = TextStyle(
    fontFamily: _family,
    fontSize: 22,
    color: ColorConstants.instance.ink,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
  );

  /// Large place/detail title ("Örnek Motel", "Son Vapur Meyhane").
  final titleFont = TextStyle(
    fontFamily: _family,
    color: ColorConstants.instance.ink,
    fontSize: 26,
    fontWeight: FontWeight.w500,
  );

  /// Section heading on detail pages ("Tesis Özellikleri", "İletişim") and
  /// list-card place names.
  final middleTitle = TextStyle(
    fontFamily: _family,
    fontSize: 20,
    color: ColorConstants.instance.ink,
    fontWeight: FontWeight.w600,
  );

  /// Compact section heading used above home lists/carousels ("Keşfet", ...).
  /// Kept in the natural olive tone for the home page's warm identity.
  final sectionTitle = TextStyle(
    fontFamily: _family,
    fontSize: 20,
    color: ColorConstants.instance.olive,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
  );

  /// Label drawn on top of images (category tiles, news cards, beaches).
  final imageFront = const TextStyle(
    fontFamily: _family,
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
    height: 1.12,
  );

  // ---- Body / UI roles -----------------------------------------------------
  final smallText = const TextStyle(
    fontFamily: _family,
    fontWeight: FontWeight.w500,
    color: Colors.white,
    fontSize: 13,
  );

  /// Uppercase eyebrow / overline used above section titles.
  final eyebrow = TextStyle(
    fontFamily: _family,
    fontSize: 11.5,
    letterSpacing: 1.4,
    fontWeight: FontWeight.w600,
    color: ColorConstants.instance.sea,
  );

  final commentTextBold = TextStyle(
    fontFamily: _family,
    fontSize: 16,
    color: ColorConstants.instance.mist,
    fontWeight: FontWeight.w500,
  );

  final explanationTextBold = TextStyle(
    fontFamily: _family,
    fontSize: 15,
    color: ColorConstants.instance.mist,
    fontWeight: FontWeight.w400,
    height: 1.6,
  );

  final commentTextThin = TextStyle(
    fontFamily: _family,
    fontSize: 14,
    color: ColorConstants.instance.mist,
    fontWeight: FontWeight.w400,
  );

  final priceFont = TextStyle(
    fontFamily: _family,
    fontWeight: FontWeight.w600,
    fontSize: 22,
    color: ColorConstants.instance.sea,
  );

  final underlineFont = TextStyle(
    fontFamily: _family,
    color: ColorConstants.instance.coral,
    decoration: TextDecoration.underline,
    decorationColor: ColorConstants.instance.coral,
    fontWeight: FontWeight.w500,
    fontSize: 15,
  );

  final imageFrontRating = const TextStyle(
    fontFamily: _family,
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  final middleWhiteColor = const TextStyle(
    fontFamily: _family,
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
}
