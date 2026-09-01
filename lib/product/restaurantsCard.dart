import 'package:flutter/material.dart';
import 'package:gokceada/core/colors.dart';
import 'package:gokceada/core/textFont.dart';
import 'package:gokceada/product/rating_label.dart';
import 'package:gokceada/product/twoImagePageView.dart';
import 'countIndicator.dart';

/// List card for restaurants / cafes / bars — same restored ("göz bebeği")
/// style as the other listing cards: image on top, then the place name with a
/// soft-blue rating chip, then a 📍 location row.
class RestaurantsCard extends StatefulWidget {
  const RestaurantsCard({
    super.key,
    required this.path,
    required this.restaurantName,
    required this.rating,
    this.location = '',
    this.reviewCount = 0,
  });

  final String path;
  final String restaurantName;
  final String rating;
  final String location;
  final int reviewCount;

  @override
  State<RestaurantsCard> createState() => _RestaurantsCardState();
}

class _RestaurantsCardState extends State<RestaurantsCard> {
  late PageController _controller;
  int imageCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  void onImageCountUpdated(int count) {
    setState(() {
      imageCount = count;
    });
  }

  bool get _hasRating {
    final r = double.tryParse(widget.rating);
    return r != null && r > 0;
  }

  @override
  Widget build(BuildContext context) {
    final c = ColorConstants.instance;
    return Card(
      elevation: 0,
      clipBehavior: Clip.hardEdge,
      color: c.shell,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1, color: c.lightGreyCardCollor),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: (MediaQuery.of(context).size.height) * 0.28,
            width: double.infinity,
            child: TwoImagePageView(
              controller: _controller,
              folderPath: widget.path,
              onImageCountUpdated: onImageCountUpdated,
            ),
          ),
          CountIndicator(controller: _controller, count: imageCount),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        widget.restaurantName,
                        style: TextFonts.instance.middleTitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (_hasRating) ...[
                      const SizedBox(width: 10),
                      RatingChip(
                          rating: widget.rating,
                          reviewCount: widget.reviewCount),
                    ],
                  ],
                ),
                if (widget.location.trim().isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, size: 19, color: c.mist),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          widget.location,
                          style: TextFonts.instance.commentTextThin,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
