import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gokceada/product/descriptionNetworkImage.dart';
import 'package:gokceada/product/navigationButton.dart';
import '../../core/colors.dart';
import '../../core/textFont.dart';
import '../../product/listing_list_view.dart';
import '../../product/networkCardDesign.dart';
import '../../providers/listing_provider.dart';

class GezilecekDetay extends StatelessWidget {
  const GezilecekDetay({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          ListingProvider()..load('gezilecekList', nameKey: 'gezilecekName'),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.7,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_ios_new,
                color: ColorConstants.instance.titleColor),
          ),
          title: Text('gormeyeDeger'.tr(),
              style: TextFonts.instance.appBarTitleColor),
        ),
        body: ListingListView(
          card: (context, l) => NetworkCardDesign(
            cardText: l.name,
            path: l.image,
          ),
          detail: (context, l) => NetworkImageDescription(
            description: l.description,
            title: l.name,
            path: l.image,
            widget: NavigationButton(
                latitude: l.latitude, longitude: l.longitude),
          ),
        ),
      ),
    );
  }
}
