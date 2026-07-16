import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gokceada/screens/hotel_rooms.dart';
import '../core/colors.dart';
import '../core/textFont.dart';
import '../models/listing.dart';
import '../product/hotelListCard.dart';
import '../product/listing_list_view.dart';
import '../providers/listing_provider.dart';

class OtelDetay extends StatelessWidget {
  const OtelDetay({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ListingProvider()..load('hotelList', nameKey: 'hotel_name'),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.7,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_ios_new,
                color: ColorConstants.instance.titleColor),
          ),
          title: Text('oteller'.tr(), style: TextFonts.instance.titleFont),
        ),
        body: ListingListView(
          card: (context, l) => HotelListCard(
            hotelName: l.name,
            location: l.location,
            rating: l.rating,
            path: l.image,
          ),
          detail: (context, l) => HotelRoomsView(
            latitude: l.latitude,
            longitude: l.longitude,
            owner: l.owner,
            facilities: _facilities(l),
            description: l.description,
            hotelName: l.name,
            location: l.location,
            telNo: l.telNo,
            path: l.image,
          ),
        ),
      ),
    );
  }
}

/// Builds the amenity icon row from the listing's parallel `icon` + `info`
/// arrays, tolerating length mismatches.
List<ContainerMiddle> _facilities(Listing l) {
  final facilities = <ContainerMiddle>[];
  for (int i = 0; i < l.icons.length; i++) {
    final info = i < l.info.length ? l.info[i] : '';
    facilities.add(
      ContainerMiddle(icon: IconsExtension.getIcon(l.icons[i]), info: info),
    );
  }
  return facilities;
}

class IconsExtension {
  static IconData getIcon(String iconName) {
    switch (iconName) {
      case 'air':
        return Icons.air;
      case 'tv':
        return Icons.tv;
      case 'mutfak':
        return Icons.soup_kitchen;
      case 'buzdolabı':
        return Icons.kitchen;
      case 'minibar':
        return Icons.local_bar;
      case 'kasa':
        return Icons.lock;
      case 'balkon':
        return Icons.balcony;
      case 'fön':
        return Icons.barcode_reader;
      case 'çamaşır':
        return Icons.local_laundry_service_outlined;
      case 'vanti':
        return Icons.wind_power;
      default:
        return Icons.error;
    }
  }
}
