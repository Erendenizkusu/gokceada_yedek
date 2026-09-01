import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gokceada/core/textFont.dart';
import 'package:gokceada/screens/restaurantDetail.dart';
import '../product/detail_widgets.dart';
import '../product/place_detail_scaffold.dart';

class CafeView extends StatelessWidget {
  const CafeView(
      {super.key,
      required this.path,
      required this.rating,
      required this.name,
      required this.location,
      required this.link,
      required this.latitude,
      required this.longitude,
      this.reviewCount = 0});

  final String path;
  final String rating;
  final int reviewCount;
  final String name;
  final String location;
  final String link;
  final double latitude;
  final double longitude;

  @override
  Widget build(BuildContext context) {
    return PlaceDetailScaffold(
      path: path,
      name: name,
      location: location,
      latitude: latitude,
      longitude: longitude,
      rating: rating,
      reviewCount: reviewCount,
      sections: [
        DetailSection(
          title: 'qrMenu'.tr(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('menuBilgilendirme'.tr(),
                  style: TextFonts.instance.explanationTextBold),
              const SizedBox(height: 12),
              LinkCard(
                icon: Icons.link,
                title: 'qrMenu'.tr(),
                onTap: () => openQrMenu(context, link),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
