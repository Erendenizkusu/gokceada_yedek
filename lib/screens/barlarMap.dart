import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gokceada/product/restaurantsCard.dart';
import 'package:gokceada/screens/restaurantDetail.dart';
import '../core/colors.dart';
import '../core/textFont.dart';
import '../product/listing_list_view.dart';
import '../providers/listing_provider.dart';

class BarDetay extends StatelessWidget {
  const BarDetay({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ListingProvider()..load('barList', nameKey: 'barName'),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.7,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_ios_new,
                color: ColorConstants.instance.titleColor),
          ),
          title: Text('barlar'.tr(), style: TextFonts.instance.titleFont),
        ),
        body: ListingListView(
          card: (context, l) => RestaurantsCard(
            restaurantName: l.name,
            rating: l.rating,
            path: l.image,
          ),
          detail: (context, l) => RestaurantView(
            latitude: l.latitude,
            longitude: l.longitude,
            link: l.link,
            name: l.name,
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
