import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gokceada/product/PansionListCard.dart';
import 'package:gokceada/screens/campingDetail.dart';
import '../core/colors.dart';
import '../core/textFont.dart';
import '../product/listing_list_view.dart';
import '../providers/listing_provider.dart';

class BreakfastDetay extends StatelessWidget {
  const BreakfastDetay({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          ListingProvider()..load('breakfastList', nameKey: 'breakfast_name'),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.7,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_ios_new,
                color: ColorConstants.instance.titleColor),
          ),
          title: Text('kahvaltiAlanlari'.tr(),
              style: TextFonts.instance.titleFont),
        ),
        body: ListingListView(
          card: (context, l) => PansionListCard(
            hotelName: l.name,
            location: l.location,
            rating: l.rating,
            reviewCount: l.reviewCount,
            path: l.image,
          ),
          detail: (context, l) => CampingDetailView(
            latitude: l.latitude,
            longitude: l.longitude,
            owner: l.owner,
            description: l.description,
            campingName: l.name,
            path: l.image,
            location: l.location,
            telNo: l.telNo,
            rating: l.rating,
            reviewCount: l.reviewCount,
          ),
        ),
      ),
    );
  }
}
