import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gokceada/screens/hotel_rooms.dart';
import '../helper/webview.dart';
import '../product/detail_widgets.dart';
import '../product/place_detail_scaffold.dart';

class SurfingView extends StatelessWidget {
  const SurfingView(
      {super.key,
      required this.path,
      this.name,
      required this.location,
      required this.link,
      required this.telNo,
      required this.latitude,
      required this.longitude,
      required this.rating,
      required this.surfingName,
      this.reviewCount = 0});

  final String path;
  final String? name;
  final String surfingName;
  final String rating;
  final int reviewCount;
  final String location;
  final String link;
  final String telNo;
  final double latitude;
  final double longitude;

  @override
  Widget build(BuildContext context) {
    return PlaceDetailScaffold(
      path: path,
      name: surfingName,
      location: location,
      latitude: latitude,
      longitude: longitude,
      telNo: telNo,
      rating: rating,
      reviewCount: reviewCount,
      sections: [
        if (link.isNotEmpty)
          DetailSection(
            title: 'dahaFazlaBilgi'.tr(),
            child: LinkCard(
              icon: Icons.public,
              title: 'Website',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      WebViewComponent(url: link, title: 'surfOkullari'.tr()),
                ),
              ),
            ),
          ),
        DetailSection(
          title: 'iletisim'.tr(),
          child: OwnerCard(owner: name ?? surfingName, telNumber: telNo),
        ),
      ],
    );
  }
}
