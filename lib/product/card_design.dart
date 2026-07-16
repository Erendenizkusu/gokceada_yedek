import 'package:flutter/material.dart';
import 'package:gokceada/core/colors.dart';
import 'package:gokceada/core/textFont.dart';
import 'package:gokceada/screens/koylerMap.dart';
import 'package:provider/provider.dart';

import '../services/google_ads.dart';

/// A category tile: a full-bleed asset image with a sea-teal scrim and the
/// category name set in the display serif. Used both as a wide hero tile and,
/// with [width]/[height] set, as a card in a horizontal "Keşfet" row.
class CardDesign extends StatelessWidget {
  const CardDesign({
    super.key,
    this.koyNames,
    required this.path,
    required this.cardText,
    this.pushWhere = '',
    this.isAd = false,
    this.width,
    this.height,
  });

  final String path;
  final String cardText;
  final String? pushWhere;
  final String? koyNames;
  final bool isAd;
  final double? width;
  final double? height;

  void _onTap(BuildContext context) {
    if (koyNames != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => createKoyler(context)[koyNames] as Widget,
        ),
      );
      return;
    }
    if (isAd) context.read<GoogleAds>().loadInterstitialAd();
    Navigator.of(context).pushNamed('/$pushWhere');
  }

  @override
  Widget build(BuildContext context) {
    final resolvedHeight =
        height ?? (MediaQuery.of(context).size.height) * 0.24;
    return SizedBox(
      width: width,
      height: resolvedHeight,
      child: Card(
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.only(bottom: 5),
        child: InkWell(
          onTap: () => _onTap(context),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(path, fit: BoxFit.cover),
              const _SeaScrim(),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    cardText,
                    style: TextFonts.instance.imageFront,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The signature deep-teal gradient that keeps on-image labels legible.
class _SeaScrim extends StatelessWidget {
  const _SeaScrim();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            ColorConstants.instance.seaDeep.withValues(alpha: 0.85),
          ],
          stops: const [0.4, 1.0],
        ),
      ),
    );
  }
}
