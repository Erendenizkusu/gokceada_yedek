import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/colors.dart';
import '../core/textFont.dart';
import 'navigationButton.dart';

/// 📍 location row (pin icon + place location) used under detail-page titles.
class DetailLocationRow extends StatelessWidget {
  const DetailLocationRow({super.key, required this.location});

  final String location;

  @override
  Widget build(BuildContext context) {
    final c = ColorConstants.instance;
    if (location.trim().isEmpty) return const SizedBox.shrink();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.location_on_outlined, size: 20, color: c.mist),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            location,
            style: TextFonts.instance.commentTextThin.copyWith(fontSize: 15),
          ),
        ),
      ],
    );
  }
}

/// The paired "Yol Tarifi" (filled blue) + "Ara" (outline blue) buttons shown
/// on every place detail page in the reference UI. "Ara" is hidden when there
/// is no phone number.
class DetailActionButtons extends StatelessWidget {
  const DetailActionButtons({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.telNo,
  });

  final double latitude;
  final double longitude;
  final String telNo;

  @override
  Widget build(BuildContext context) {
    final c = ColorConstants.instance;
    final hasPhone = telNo.trim().isNotEmpty;

    final directions = Expanded(
      child: SizedBox(
        height: 52,
        child: ElevatedButton.icon(
          onPressed: () => openMapsApp(context, latitude, longitude),
          icon: const Icon(Icons.near_me, size: 20),
          label: Text('yolTarifi'.tr()),
          style: ElevatedButton.styleFrom(
            backgroundColor: c.sea,
            foregroundColor: Colors.white,
            elevation: 0,
            textStyle: TextFonts.instance.commentTextBold
                .copyWith(color: Colors.white, fontSize: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ),
    );

    if (!hasPhone) return Row(children: [directions]);

    return Row(
      children: [
        directions,
        const SizedBox(width: 12),
        Expanded(
          child: SizedBox(
            height: 52,
            child: OutlinedButton.icon(
              onPressed: () => launchUrl(Uri.parse('tel:$telNo')),
              icon: const Icon(Icons.call_outlined, size: 20),
              label: Text('ara'.tr()),
              style: OutlinedButton.styleFrom(
                foregroundColor: c.sea,
                side: BorderSide(color: c.sea, width: 1.4),
                textStyle: TextFonts.instance.commentTextBold
                    .copyWith(color: c.sea, fontSize: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// The "Konum — Haritada aç ve yol tarifi al" card that opens the maps app.
class LocationCard extends StatelessWidget {
  const LocationCard({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  @override
  Widget build(BuildContext context) {
    final c = ColorConstants.instance;
    return Material(
      color: c.textFieldBacgroundColor,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => openMapsApp(context, latitude, longitude),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(Icons.map_outlined, color: c.sea, size: 26),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('konum'.tr(),
                        style: TextFonts.instance.middleTitle
                            .copyWith(fontSize: 17)),
                    const SizedBox(height: 2),
                    Text('konumAciklama'.tr(),
                        style: TextFonts.instance.commentTextThin),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: c.mist),
            ],
          ),
        ),
      ),
    );
  }
}

/// Left-aligned section title ("Tesis Özellikleri", "Oda Özellikleri", ...).
class DetailSectionTitle extends StatelessWidget {
  const DetailSectionTitle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextFonts.instance.middleTitle);
  }
}

/// A titled detail section: a heading with the given [child] below it, plus the
/// standard top spacing used between sections on the reference detail pages.
class DetailSection extends StatelessWidget {
  const DetailSection({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        DetailSectionTitle(title),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}

/// A tappable card with a leading icon, title and chevron — used for the
/// restaurant "QR Menu" link, styled like the Konum card.
class LinkCard extends StatelessWidget {
  const LinkCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = ColorConstants.instance;
    return Material(
      color: c.shell,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(width: 1, color: c.lightGreyCardCollor),
          ),
          child: Row(
            children: [
              Icon(icon, color: c.sea, size: 24),
              const SizedBox(width: 14),
              Expanded(
                child: Text(title,
                    style:
                        TextFonts.instance.middleTitle.copyWith(fontSize: 17)),
              ),
              Icon(Icons.chevron_right, color: c.mist),
            ],
          ),
        ),
      ),
    );
  }
}
