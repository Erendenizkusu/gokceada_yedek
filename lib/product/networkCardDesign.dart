import 'package:flutter/material.dart';
import 'package:gokceada/core/colors.dart';
import 'package:gokceada/core/textFont.dart';
import 'package:gokceada/product/restaurantCardImage.dart';

/// Like [CardDesign] but backed by a Firebase Storage image. Used for the
/// "gezilecek" and "aktiviteler" list cards.
class NetworkCardDesign extends StatelessWidget {
  const NetworkCardDesign(
      {super.key, required this.path, required this.cardText});
  final String path;
  final String cardText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (MediaQuery.of(context).size.height) * 0.3,
      child: Card(
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.all(8),
        child: Stack(
          fit: StackFit.expand,
          children: [
            RestaurantImage(folderPath: path),
            DecoratedBox(
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
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
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
    );
  }
}
