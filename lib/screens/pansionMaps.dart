import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gokceada/product/PansionListCard.dart';
import 'package:gokceada/screens/pansionDetail.dart';
import '../core/colors.dart';
import '../core/textFont.dart';
import '../product/listing_list_view.dart';
import '../providers/listing_provider.dart';
import 'hotel_rooms.dart';
import 'hotelsMap.dart';

class PansionDetay extends StatelessWidget {
  const PansionDetay({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          ListingProvider()..load('pansionList', nameKey: 'pansion_name'),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.7,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_ios_new,
                color: ColorConstants.instance.titleColor),
          ),
          title: Text('pansionlar'.tr(), style: TextFonts.instance.titleFont),
        ),
        body: ListingListView(
          card: (context, l) => PansionListCard(
            hotelName: l.name,
            location: l.location,
            rating: l.rating,
            reviewCount: l.reviewCount,
            path: l.image,
          ),
          detail: (context, l) {
            final facilities = <ContainerMiddle>[];
            for (int i = 0; i < l.icons.length; i++) {
              final info = i < l.info.length ? l.info[i] : '';
              facilities.add(ContainerMiddle(
                  icon: IconsExtension.getIcon(l.icons[i]), info: info));
            }
            return PansionDetailView(
              latitude: l.latitude,
              longitude: l.longitude,
              owner: l.owner,
              facilities: facilities,
              description: l.description,
              pansion_name: l.name,
              path: l.image,
              location: l.location,
              telNo: l.telNo,
              rating: l.rating,
              reviewCount: l.reviewCount,
            );
          },
        ),
      ),
    );
  }
}
