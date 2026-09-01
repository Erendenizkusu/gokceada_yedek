import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../core/colors.dart';
import '../core/textFont.dart';

/// Formats a rating + Google review count the way the old UI did:
/// "4.7 ★ (280 yorum)" — the count is dropped when it is 0.
String _ratingText(String rating, int reviewCount) {
  final buffer = StringBuffer('$rating ★');
  if (reviewCount > 0) {
    buffer.write(' ($reviewCount ${'yorum'.tr()})');
  }
  return buffer.toString();
}

/// Detail-screen rating row: a gold star followed by "4.7 ★ (280 yorum)".
/// Matches the reference place pages (hotels, restaurants, pansions...).
class RatingLabel extends StatelessWidget {
  const RatingLabel({
    super.key,
    required this.rating,
    required this.reviewCount,
  });

  final String rating;
  final int reviewCount;

  @override
  Widget build(BuildContext context) {
    final c = ColorConstants.instance;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star_rounded, color: c.gold, size: 24),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            _ratingText(rating, reviewCount),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextFonts.instance.middleTitle
                .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}

/// Compact rating pill used on list cards: a soft blue rounded chip reading
/// "4.7 ★ (280 yorum)" (or just "4.7 ★" when there are no reviews yet).
class RatingChip extends StatelessWidget {
  const RatingChip({
    super.key,
    required this.rating,
    required this.reviewCount,
  });

  final String rating;
  final int reviewCount;

  @override
  Widget build(BuildContext context) {
    final c = ColorConstants.instance;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: c.sea.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _ratingText(rating, reviewCount),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextFonts.instance.commentTextBold.copyWith(
          color: c.sea,
          fontSize: 14.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
