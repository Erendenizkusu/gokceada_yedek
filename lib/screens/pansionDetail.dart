import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gokceada/core/textFont.dart';
import 'package:gokceada/screens/hotel_rooms.dart';
import '../product/detail_widgets.dart';
import '../product/place_detail_scaffold.dart';

class PansionDetailView extends StatelessWidget {
  const PansionDetailView(
      {super.key,
      required this.path,
      required this.description,
      required this.location,
      required this.facilities,
      required this.owner,
      required this.telNo,
      required this.rating,
      required this.latitude,
      required this.longitude,
      required this.pansion_name,
      this.reviewCount = 0});

  final String path;
  final String pansion_name;
  final double latitude;
  final double longitude;
  final String description;
  final String location;
  final List<ContainerMiddle> facilities;
  final String owner;
  final String telNo;
  final String rating;
  final int reviewCount;

  @override
  Widget build(BuildContext context) {
    return PlaceDetailScaffold(
      path: path,
      name: pansion_name,
      location: location,
      latitude: latitude,
      longitude: longitude,
      telNo: telNo,
      rating: rating,
      reviewCount: reviewCount,
      sections: [
        if (facilities.isNotEmpty)
          DetailSection(
            title: 'odaOzellikleri'.tr(),
            child: Wrap(spacing: 10, runSpacing: 10, children: facilities),
          ),
        if (description.trim().isNotEmpty)
          DetailSection(
            title: 'tesisOzellikleri'.tr(),
            child: Text(description,
                style: TextFonts.instance.explanationTextBold),
          ),
        DetailSection(
          title: 'iletisim'.tr(),
          child: OwnerCard(owner: owner, telNumber: telNo),
        ),
      ],
    );
  }
}
