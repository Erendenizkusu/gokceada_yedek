import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gokceada/services/google_ads.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../core/colors.dart';
import '../../core/textFont.dart';
import '../../product/card_design.dart';
import '../product/news_carousel.dart';
import '../providers/news_provider.dart';
import '../screens/navBar.dart';
import '../screens/restaurantDetail.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<ImageCardDesign> gokceadaPhotos = const [
    ImageCardDesign(image: 'images/gokceadaDirectory/gokceada.jpg'),
    ImageCardDesign(image: 'images/gokceadaDirectory/gokceada1.jpg'),
    ImageCardDesign(image: 'images/gokceadaDirectory/gokceada2.jpg'),
    ImageCardDesign(image: 'images/gokceadaDirectory/gokceada3.jpg'),
    ImageCardDesign(image: 'images/gokceadaDirectory/gokceada4.jpg'),
    ImageCardDesign(image: 'images/gokceadaDirectory/gokceada5.jpg'),
    ImageCardDesign(image: 'images/gokceadaDirectory/gokceada6.jpeg'),
  ];

  // Category tiles shown in the horizontal "Keşfet" row.
  List<CardDesign> get _categories => [
        CardDesign(
            path: 'images/otel.jpg',
            cardText: 'oteller'.tr(),
            pushWhere: 'oteller',
            isAd: true),
        CardDesign(
            path: 'images/pansiyon.jpg',
            cardText: 'pansionlar'.tr(),
            pushWhere: 'pansionList'),
        CardDesign(
            path: 'images/restourant.jpg',
            cardText: 'restoranlar'.tr(),
            pushWhere: 'restaurantsView',
            isAd: true),
        CardDesign(
            path: 'images/kamp_alanları.jpg',
            cardText: 'kampalanlari'.tr(),
            pushWhere: 'camping',
            isAd: true),
        CardDesign(
            path: 'images/yildizkoy/yildizkoy.jpg',
            cardText: 'plajlar'.tr(),
            pushWhere: 'plajlar',
            isAd: true),
        CardDesign(
            path: 'images/surfing.jpg',
            cardText: 'surfOkullari'.tr(),
            pushWhere: 'surfing'),
      ];

  @override
  void initState() {
    super.initState();
    context.read<GoogleAds>().loadBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    final googleAds = context.watch<GoogleAds>();
    final news = context.watch<NewsProvider>();

    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        title: const Text('Gökçeada'),
        actions: [
          IconButton(
            tooltip: 'sizinGozunuzdenAda'.tr(),
            icon: const Icon(Icons.photo_camera_outlined),
            onPressed: () =>
                Navigator.of(context).pushNamed('/usersConsole'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          Text('adaEtiketi'.tr(), style: TextFonts.instance.eyebrow),
          const SizedBox(height: 14),
          if (news.hasNews) ...[
            const _SectionHead(titleKey: 'guncelHaberler'),
            const SizedBox(height: 12),
            NewsCarousel(items: news.items),
            const SizedBox(height: 8),
          ],
          const _SectionHead(titleKey: 'kesfet'),
          const SizedBox(height: 12),
          SizedBox(
            height: 148,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) => SizedBox(
                width: 152,
                child: _categories[index],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              CategoryChip(
                  text: 'gormeyeDeger'.tr(),
                  route: 'gezilecek',
                  icon: Icons.remove_red_eye_outlined),
              CategoryChip(
                  text: 'neredeYenir'.tr(),
                  route: 'foodareas',
                  icon: Icons.restaurant_outlined,
                  isAd: true,
                  highlighted: true),
              CategoryChip(
                  text: 'aktiviteler'.tr(),
                  route: 'activities',
                  icon: Icons.surfing),
              CategoryChip(
                  text: 'atm'.tr(), route: 'atm', icon: Icons.atm_outlined),
              CategoryChip(
                  text: 'otobusSaatleri'.tr(),
                  route: 'bus',
                  icon: Icons.directions_bus_outlined,
                  isAd: true),
              CategoryChip(
                  text: 'feribotSaatleri'.tr(),
                  route: 'fery',
                  icon: Icons.directions_ferry_outlined,
                  isAd: true),
            ],
          ),
          const SizedBox(height: 24),
          const _SectionHead(titleKey: 'adayiTani'),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: CircularImagesTop(list: gokceadaPhotos),
          ),
          const SizedBox(height: 8),
          Text('gezilecekKoyler'.tr(), style: TextFonts.instance.sectionTitle),
          const SizedBox(height: 8),
          Text('gezilecekKoylerAciklama'.tr(),
              style: TextFonts.instance.explanationTextBold),
          const SizedBox(height: 16),
          Text('koylarSahiller'.tr(), style: TextFonts.instance.sectionTitle),
          const SizedBox(height: 8),
          Text('koylarSahillerAciklama'.tr(),
              style: TextFonts.instance.explanationTextBold),
        ],
      ),
      bottomNavigationBar: googleAds.bannerAd != null
          ? SizedBox(
              height: googleAds.bannerAd?.size.height.toDouble(),
              width: MediaQuery.of(context).size.width,
              child: AdWidget(ad: googleAds.bannerAd!),
            )
          : const SizedBox(),
    );
  }
}

/// Section heading with the signature coral "horizon" underline.
class _SectionHead extends StatelessWidget {
  const _SectionHead({required this.titleKey});
  final String titleKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titleKey.tr(), style: TextFonts.instance.sectionTitle),
        const SizedBox(height: 6),
        Container(
          width: 38,
          height: 3,
          decoration: BoxDecoration(
            color: ColorConstants.instance.coral,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ],
    );
  }
}

/// Pill-shaped quick-access chip for a home shortcut. Opens the named route,
/// optionally firing an interstitial ad first.
class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.text,
    required this.route,
    required this.icon,
    this.isAd = false,
    this.highlighted = false,
  });

  final String text;
  final String route;
  final IconData icon;
  final bool isAd;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final c = ColorConstants.instance;
    final accent = highlighted ? c.coral : c.olive;
    return Material(
      color: c.shell,
      shape: StadiumBorder(
        side: BorderSide(
          color: highlighted
              ? c.coral.withValues(alpha: 0.45)
              : c.sea.withValues(alpha: 0.14),
        ),
      ),
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: () {
          if (isAd) context.read<GoogleAds>().loadInterstitialAd();
          Navigator.pushNamed(context, '/$route');
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: accent),
              const SizedBox(width: 7),
              Text(
                text,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: highlighted ? c.coral : c.seaDeep,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
