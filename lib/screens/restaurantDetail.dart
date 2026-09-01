import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gokceada/screens/hotel_rooms.dart';
import '../core/colors.dart';
import '../core/textFont.dart';
import '../product/detail_widgets.dart';
import '../product/indicatorWidget.dart';
import '../product/place_detail_scaffold.dart';
import '../helper/webview.dart';

class RestaurantView extends StatelessWidget {
  const RestaurantView(
      {super.key,
      required this.path,
      required this.rating,
      required this.name,
      required this.location,
      required this.link,
      required this.telNo,
      required this.latitude,
      required this.longitude,
      this.reviewCount = 0});

  final String path;
  final String rating;
  final int reviewCount;
  final String name;
  final String location;
  final String link;
  final String telNo;
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
      telNo: telNo,
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
        DetailSection(
          title: 'iletisim'.tr(),
          child: OwnerCard(owner: name, telNumber: telNo),
        ),
      ],
    );
  }
}

/// Opens a QR/web menu in the in-app webview, or shows a "no menu" dialog when
/// the listing has no link. Shared by restaurant + cafe detail pages.
void openQrMenu(BuildContext context, String link) {
  if (link.isNotEmpty) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewComponent(url: link, title: 'QR MENU'),
      ),
    );
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('qrMenuBulunmuyor'.tr()),
          title: Text('qrMenuBulunamadi'.tr()),
          backgroundColor: ColorConstants.instance.lightGreyCardCollor,
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('tamam'.tr(),
                  style: TextFonts.instance.commentTextThin),
            ),
          ],
        );
      },
    );
  }
}

class CircularImagesTop extends StatelessWidget {
  CircularImagesTop({
    super.key,
    required this.list,
  });

  final List<ImageCardDesign> list;
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: (MediaQuery.of(context).size.height) * 0.4,
        width: (MediaQuery.of(context).size.width),
        child: PageView(
          controller: _controller,
          children: list,
        ),
      ),
      Indicator(controller: _controller, list: list)
    ]);
  }
}

class ImageCardDesign extends StatelessWidget {
  const ImageCardDesign({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Image.asset(
        image,
        fit: BoxFit.fill,
      ),
    );
  }
}

class InkwellUnderline extends StatelessWidget {
  const InkwellUnderline({
    super.key,
    required this.name,
    required this.onTap,
  });
  final String name;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        name,
        style: TextFonts.instance.underlineFont,
      ),
    );
  }
}
