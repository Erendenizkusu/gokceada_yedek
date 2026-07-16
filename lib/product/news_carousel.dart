import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../core/colors.dart';
import '../core/textFont.dart';
import '../helper/webview.dart';
import '../models/news_item.dart';

/// Hero carousel of current Gökçeada news shown at the top of the home screen.
/// Each card is a full-bleed image with the headline overlaid; tapping opens
/// the article in an in-app [WebViewComponent] without leaving the app.
///
/// Data comes from the Firestore `news` collection via `NewsProvider`; this
/// widget is purely presentational and receives the already-loaded [items].
class NewsCarousel extends StatefulWidget {
  const NewsCarousel({super.key, required this.items, this.height = 200});

  final List<NewsItem> items;
  final double height;

  @override
  State<NewsCarousel> createState() => _NewsCarouselState();
}

class _NewsCarouselState extends State<NewsCarousel> {
  final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.items;
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            controller: _controller,
            itemCount: items.length,
            itemBuilder: (context, index) => _NewsCard(item: items[index]),
          ),
        ),
        const SizedBox(height: 10),
        if (items.length > 1)
          SmoothPageIndicator(
            controller: _controller,
            count: items.length,
            effect: ExpandingDotsEffect(
              activeDotColor: ColorConstants.instance.activatedButton,
              dotColor: ColorConstants.instance.lightGreyCardCollor,
              dotHeight: 8,
              dotWidth: 8,
              expansionFactor: 3,
              spacing: 6,
            ),
          ),
      ],
    );
  }
}

class _NewsCard extends StatelessWidget {
  const _NewsCard({required this.item});

  final NewsItem item;

  void _open(BuildContext context) {
    if (!item.hasLink) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WebViewComponent(url: item.linkUrl, title: item.title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        onTap: () => _open(context),
        borderRadius: BorderRadius.circular(16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: item.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: ColorConstants.instance.lightGreyCardCollor,
                  child: const Center(
                    child: SizedBox(
                      width: 26,
                      height: 26,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: ColorConstants.instance.lightGreyCardCollor,
                  child: Icon(Icons.image_not_supported_outlined,
                      color: ColorConstants.instance.commentColor, size: 32),
                ),
              ),
              // Bottom scrim so the headline stays readable over any image.
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black87],
                    stops: [0.45, 1.0],
                  ),
                ),
              ),
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextFonts.instance.imageFront.copyWith(fontSize: 20),
                    ),
                    if (item.subtitle.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        item.subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextFonts.instance.middleWhiteColor
                            .copyWith(fontSize: 13),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
