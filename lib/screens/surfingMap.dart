import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gokceada/product/PansionListCard.dart';
import 'package:gokceada/screens/surfing.dart';
import '../core/colors.dart';
import '../core/textFont.dart';
import '../product/listing_list_view.dart';
import '../providers/listing_provider.dart';

class SurfingDetay extends StatelessWidget {
  const SurfingDetay({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Note: the surfing documents store the school name under the
      // `restaurant_name` key (a leftover from when this collection was copied
      // from restaurants), so that is the correct nameKey here.
      create: (_) =>
          ListingProvider()..load('surfingList', nameKey: 'restaurant_name'),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.7,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_ios_new,
                color: ColorConstants.instance.titleColor),
          ),
          title:
              Text('surfOkullari'.tr(), style: TextFonts.instance.titleFont),
        ),
        body: ListingListView(
          card: (context, l) => PansionListCard(
            hotelName: l.name,
            location: l.location,
            rating: l.rating,
            path: l.image,
          ),
          detail: (context, l) => SurfingView(
            latitude: l.latitude,
            longitude: l.longitude,
            surfingName: l.name,
            link: l.link,
            name: l.owner,
            path: l.image,
            location: l.location,
            telNo: l.telNo,
            rating: l.rating,
          ),
        ),
      ),
    );
  }
}
