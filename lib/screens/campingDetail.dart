import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gokceada/core/textFont.dart';
import 'package:gokceada/screens/hotel_rooms.dart';
import '../product/detail_widgets.dart';
import '../product/place_detail_scaffold.dart';

class CampingDetailView extends StatelessWidget {
  const CampingDetailView(
      {super.key,
      required this.path,
      required this.description,
      required this.location,
      required this.telNo,
      required this.rating,
      required this.campingName,
      required this.latitude,
      required this.longitude,
      this.owner,
      this.reviewCount = 0});

  final String path;
  final String campingName;
  final String description;
  final String? owner;
  final String location;
  final String telNo;
  final String rating;
  final int reviewCount;
  final double latitude;
  final double longitude;

  @override
  Widget build(BuildContext context) {
    return PlaceDetailScaffold(
      path: path,
      name: campingName,
      location: location,
      latitude: latitude,
      longitude: longitude,
      telNo: telNo,
      rating: rating,
      reviewCount: reviewCount,
      sections: [
        if (description.trim().isNotEmpty)
          DetailSection(
            title: 'tesisOzellikleri'.tr(),
            child: Text(description,
                style: TextFonts.instance.explanationTextBold),
          ),
        DetailSection(
          title: 'iletisim'.tr(),
          child: OwnerCard(owner: owner ?? campingName, telNumber: telNo),
        ),
      ],
    );
  }
}
