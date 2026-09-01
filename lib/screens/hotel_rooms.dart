import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gokceada/core/colors.dart';
import 'package:gokceada/core/textFont.dart';
import 'package:url_launcher/url_launcher.dart';
import '../product/detail_widgets.dart';
import '../product/place_detail_scaffold.dart';

class HotelRoomsView extends StatelessWidget {
  const HotelRoomsView(
      {super.key,
      required this.description,
      required this.location,
      required this.hotelName,
      required this.facilities,
      required this.owner,
      required this.latitude,
      required this.longitude,
      required this.telNo,
      required this.path,
      this.rating = '',
      this.reviewCount = 0});

  final double latitude;
  final double longitude;
  final String hotelName;
  final String description;
  final String location;
  final List<ContainerMiddle> facilities;
  final String owner;
  final String telNo;
  final String path;
  final String rating;
  final int reviewCount;

  @override
  Widget build(BuildContext context) {
    return PlaceDetailScaffold(
      path: path,
      name: hotelName,
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
        if (facilities.isNotEmpty)
          DetailSection(
            title: 'odaOzellikleri'.tr(),
            child: Wrap(spacing: 10, runSpacing: 10, children: facilities),
          ),
        DetailSection(
          title: 'iletisim'.tr(),
          child: OwnerCard(owner: owner, telNumber: telNo),
        ),
      ],
    );
  }
}

class OwnerCard extends StatelessWidget {
  const OwnerCard({
    super.key,
    required this.owner,
    required this.telNumber,
  });

  final String owner;
  final String telNumber;

  @override
  Widget build(BuildContext context) {
    final Uri phoneNumber = Uri.parse('tel:$telNumber');

    final c = ColorConstants.instance;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
          color: c.shell,
          border: Border.all(width: 1, color: c.lightGreyCardCollor),
          borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: c.sea.withValues(alpha: 0.10),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.person_outline, color: c.sea),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(owner,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextFonts.instance.middleTitle),
                const SizedBox(height: 2),
                Text('${'iletisim'.tr()}: $telNumber',
                    style: TextFonts.instance.commentTextThin),
              ],
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () async {
              launchUrl(phoneNumber);
            },
            child: Container(
              padding: const EdgeInsets.all(11),
              decoration: BoxDecoration(
                color: c.sea.withValues(alpha: 0.10),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.call, color: c.sea),
            ),
          ),
        ],
      ),
    );
  }
}

class ContainerMiddle extends StatelessWidget {
  const ContainerMiddle({super.key, required this.icon, required this.info});

  final IconData icon;
  final String info;

  @override
  Widget build(BuildContext context) {
    final c = ColorConstants.instance;
    return Container(
      decoration: BoxDecoration(
          color: c.textFieldBacgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1, color: c.lightGreyCardCollor)),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 22, color: c.sea),
          const SizedBox(width: 9),
          Text(info,
              style: TextFonts.instance.commentTextBold
                  .copyWith(color: c.ink, fontSize: 15)),
        ],
      ),
    );
  }
}
