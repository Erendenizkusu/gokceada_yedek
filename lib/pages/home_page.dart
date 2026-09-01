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
    final c = ColorConstants.instance;

    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: const NavBar(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: c.sunset),
        actionsIconTheme: IconThemeData(color: c.sunset),
        title: ShaderMask(
          shaderCallback: (rect) => LinearGradient(
            colors: [c.sunGold, c.sunset],
          ).createShader(rect),
          blendMode: BlendMode.srcIn,
          child: Text(
            'Gökçeada',
            style: TextFonts.instance.appBarTitleColor
                .copyWith(color: Colors.white),
          ),
        ),
      ),
      body: Stack(
        children: [
          const Positioned.fill(child: _SunsetAmbience()),
          ListView(
            padding: EdgeInsets.fromLTRB(
                16,
                MediaQuery.of(context).padding.top + kToolbarHeight + 8,
                16,
                24),
            children: [
              // 1) Güncel haberler — stays on top (the loved current design).
              if (news.hasNews) ...[
                const _SectionHead(titleKey: 'guncelHaberler'),
                const SizedBox(height: 12),
                NewsCarousel(items: news.items),
                const SizedBox(height: 22),
              ],
              // 2) Keşfet — unchanged horizontal category cards.
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
              // 3) Tappable search bar (from the old UI) — opens the category
              //    picker sheet. It is a button, not a text field.
              const _SearchBarButton(),
              const SizedBox(height: 16),
              // 4) Horizontal, scrollable icon + label quick actions.
              _QuickActionsRow(
                items: [
                  _QuickActionData(
                    icon: Icons.landscape_rounded,
                    label: 'gormeyeDeger'.tr(),
                    route: 'gezilecek',
                  ),
                  _QuickActionData(
                    icon: Icons.restaurant_rounded,
                    label: 'neredeYenir'.tr(),
                    route: 'foodareas',
                    isAd: true,
                  ),
                  _QuickActionData(
                    icon: Icons.kayaking_rounded,
                    label: 'aktiviteler'.tr(),
                    route: 'activities',
                  ),
                  _QuickActionData(
                    icon: Icons.local_atm_rounded,
                    label: 'atm'.tr(),
                    route: 'atm',
                  ),
                  _QuickActionData(
                    icon: Icons.directions_bus_rounded,
                    label: 'otobusSaatleri'.tr(),
                    route: 'bus',
                    isAd: true,
                  ),
                  _QuickActionData(
                    icon: Icons.directions_boat_rounded,
                    label: 'feribotSaatleri'.tr(),
                    route: 'fery',
                    isAd: true,
                  ),
                ],
              ),
              const SizedBox(height: 26),
              // 5) Adayı tanı — kept.
              const _SectionHead(titleKey: 'adayiTani'),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: CircularImagesTop(list: gokceadaPhotos),
              ),
              const SizedBox(height: 8),
              Text('gezilecekKoyler'.tr(),
                  style: TextFonts.instance.sectionTitle),
              const SizedBox(height: 8),
              Text('gezilecekKoylerAciklama'.tr(),
                  style: TextFonts.instance.explanationTextBold),
              const SizedBox(height: 16),
              Text('koylarSahiller'.tr(),
                  style: TextFonts.instance.sectionTitle),
              const SizedBox(height: 8),
              Text('koylarSahillerAciklama'.tr(),
                  style: TextFonts.instance.explanationTextBold),
            ],
          ),
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

/// Section heading ("Explore", "About the Island", ...) in the natural olive
/// voice, with a warm sunset rule spanning the full width of the text.
class _SectionHead extends StatelessWidget {
  const _SectionHead({required this.titleKey});
  final String titleKey;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(titleKey.tr(), style: TextFonts.instance.sectionTitle),
            const SizedBox(height: 6),
            Container(
              height: 3,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ColorConstants.instance.sunGold,
                    ColorConstants.instance.sunset,
                  ],
                ),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The "Gökçeada'da keşfet" search bar from the original UI. It is a tappable
/// button (not an input); tapping opens the category picker bottom sheet.
class _SearchBarButton extends StatelessWidget {
  const _SearchBarButton();

  @override
  Widget build(BuildContext context) {
    final c = ColorConstants.instance;
    return Material(
      color: c.shell,
      elevation: 0,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => _showCategorySheet(context),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: c.lightGreyCardCollor),
            boxShadow: [
              BoxShadow(
                color: c.ink.withValues(alpha: 0.05),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(Icons.search, color: c.sea, size: 26),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('gokceadaKesfet'.tr(),
                        style: TextFonts.instance.middleTitle
                            .copyWith(fontSize: 17)),
                    const SizedBox(height: 1),
                    Text('kesfetPlaceholder'.tr(),
                        style: TextFonts.instance.commentTextThin),
                  ],
                ),
              ),
              Icon(Icons.tune, color: c.mist),
            ],
          ),
        ),
      ),
    );
  }
}

/// A single category shown in the "Nereye gitmek istersin?" sheet.
class _CategoryItem {
  const _CategoryItem({required this.icon, required this.label, required this.route});
  final IconData icon;
  final String label;
  final String route;
}

void _showCategorySheet(BuildContext context) {
  final c = ColorConstants.instance;
  final categories = <_CategoryItem>[
    _CategoryItem(icon: Icons.hotel_rounded, label: 'oteller'.tr(), route: 'oteller'),
    _CategoryItem(icon: Icons.night_shelter_rounded, label: 'pansionlar'.tr(), route: 'pansionList'),
    _CategoryItem(icon: Icons.restaurant_rounded, label: 'restoranlar'.tr(), route: 'restaurantsView'),
    _CategoryItem(icon: Icons.ramen_dining_rounded, label: 'neredeYenir'.tr(), route: 'foodareas'),
    _CategoryItem(icon: Icons.beach_access_rounded, label: 'plajlar'.tr(), route: 'plajlar'),
    _CategoryItem(icon: Icons.holiday_village_rounded, label: 'kampalanlari'.tr(), route: 'camping'),
    _CategoryItem(icon: Icons.location_city_rounded, label: 'koyler'.tr(), route: 'koyler'),
    _CategoryItem(icon: Icons.explore_rounded, label: 'gormeyeDeger'.tr(), route: 'gezilecek'),
  ];

  showModalBottomSheet(
    context: context,
    backgroundColor: c.shell,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (sheetContext) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('nereyeGitmek'.tr(), style: TextFonts.instance.titleFont),
              const SizedBox(height: 8),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: categories.length,
                  separatorBuilder: (_, __) =>
                      Divider(height: 1, color: c.lightGreyCardCollor),
                  itemBuilder: (context, index) {
                    final cat = categories[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(cat.icon,
                          color: c.sea.withValues(alpha: 0.70), size: 24),
                      title: Text(cat.label,
                          style: TextFonts.instance.middleTitle.copyWith(
                              fontSize: 16.5, fontWeight: FontWeight.w500)),
                      trailing: Icon(Icons.chevron_right, color: c.mist),
                      onTap: () {
                        Navigator.of(sheetContext).pop();
                        Navigator.pushNamed(context, '/${cat.route}');
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

/// A soft, page-wide sunset atmosphere behind the whole home screen.
class _SunsetAmbience extends StatelessWidget {
  const _SunsetAmbience();

  @override
  Widget build(BuildContext context) {
    final c = ColorConstants.instance;
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: -150,
            right: -90,
            child: _Glow(color: c.sunset, size: 380, alpha: 0.14),
          ),
          Positioned(
            top: 110,
            left: -120,
            child: _Glow(color: c.sunGold, size: 320, alpha: 0.12),
          ),
          Positioned(
            bottom: 150,
            left: -100,
            child: _Glow(color: c.olive, size: 300, alpha: 0.06),
          ),
          Positioned(
            bottom: -130,
            right: -70,
            child: _Glow(color: c.sea, size: 340, alpha: 0.06),
          ),
        ],
      ),
    );
  }
}

/// A single soft circular colour glow that fades to transparent.
class _Glow extends StatelessWidget {
  const _Glow({required this.color, required this.size, required this.alpha});

  final Color color;
  final double size;
  final double alpha;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color.withValues(alpha: alpha),
            color.withValues(alpha: 0.0),
          ],
        ),
      ),
    );
  }
}

/// Data for a single home quick-action shortcut.
class _QuickActionData {
  const _QuickActionData({
    required this.icon,
    required this.label,
    required this.route,
    this.isAd = false,
  });

  final IconData icon;
  final String label;
  final String route;
  final bool isAd;
}

/// Horizontal, scrollable row of icon + label quick-action chips (bus/ferry
/// times, ATMs, sights, ...), matching the restored UI's under-search shortcuts.
class _QuickActionsRow extends StatelessWidget {
  const _QuickActionsRow({required this.items});

  final List<_QuickActionData> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) => _QuickActionChip(data: items[index]),
      ),
    );
  }
}

class _QuickActionChip extends StatelessWidget {
  const _QuickActionChip({required this.data});

  final _QuickActionData data;

  void _onTap(BuildContext context) {
    if (data.isAd) context.read<GoogleAds>().loadInterstitialAd();
    Navigator.pushNamed(context, '/${data.route}');
  }

  @override
  Widget build(BuildContext context) {
    final c = ColorConstants.instance;
    return Material(
      color: c.shell,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => _onTap(context),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: c.lightGreyCardCollor),
          ),
          child: Row(
            children: [
              Icon(data.icon, size: 20, color: c.sea),
              const SizedBox(width: 8),
              Text(
                data.label,
                style: TextFonts.instance.commentTextBold.copyWith(
                  fontSize: 14,
                  color: c.ink,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
