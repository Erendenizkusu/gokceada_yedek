import 'package:flutter/material.dart';

import '../core/textFont.dart';
import 'countIndicator.dart';
import 'detail_widgets.dart';
import 'imagePageView.dart';
import 'rating_label.dart';

/// The one shared place-detail layout used by every venue screen (hotel,
/// pansion, restaurant, camping, surf, cafe), matching the restored reference:
///
///   hero image pager (dots + "1/10") → back button
///   title
///   📍 location
///   ⭐ rating ★ (N yorum)         (only when a rating exists)
///   [ Yol Tarifi ] [ Ara ]
///   Konum card
///   ...caller-supplied sections (description, facilities, QR menu, owner)
class PlaceDetailScaffold extends StatefulWidget {
  const PlaceDetailScaffold({
    super.key,
    required this.path,
    required this.name,
    required this.location,
    required this.latitude,
    required this.longitude,
    this.rating = '',
    this.reviewCount = 0,
    this.telNo = '',
    this.sections = const [],
  });

  final String path;
  final String name;
  final String location;
  final double latitude;
  final double longitude;
  final String rating;
  final int reviewCount;
  final String telNo;

  /// Extra content rendered below the Konum card (built with [DetailSection],
  /// facility wraps, [LinkCard], OwnerCard, ...).
  final List<Widget> sections;

  @override
  State<PlaceDetailScaffold> createState() => _PlaceDetailScaffoldState();
}

class _PlaceDetailScaffoldState extends State<PlaceDetailScaffold> {
  late final PageController _controller = PageController();
  int imageCount = 0;

  void _onImageCountUpdated(int count) => setState(() => imageCount = count);

  bool get _hasRating {
    final r = double.tryParse(widget.rating);
    return r != null && r > 0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                width: double.infinity,
                child: ImagePageView(
                  folderPath: widget.path,
                  controller: _controller,
                  onImageCountUpdated: _onImageCountUpdated,
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top + 6,
                left: 8,
                child: CircleAvatar(
                  backgroundColor: Colors.black.withValues(alpha: 0.35),
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_ios_new,
                        color: Colors.white, size: 20),
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: CountIndicator(controller: _controller, count: imageCount),
          ),
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.name, style: TextFonts.instance.titleFont),
                const SizedBox(height: 8),
                DetailLocationRow(location: widget.location),
                if (_hasRating) ...[
                  const SizedBox(height: 12),
                  RatingLabel(
                      rating: widget.rating, reviewCount: widget.reviewCount),
                ],
                const SizedBox(height: 18),
                DetailActionButtons(
                  latitude: widget.latitude,
                  longitude: widget.longitude,
                  telNo: widget.telNo,
                ),
                const SizedBox(height: 14),
                LocationCard(
                    latitude: widget.latitude, longitude: widget.longitude),
                ...widget.sections,
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
