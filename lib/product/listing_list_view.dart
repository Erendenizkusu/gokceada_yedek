import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/colors.dart';
import '../core/textFont.dart';
import '../models/listing.dart';
import '../providers/listing_provider.dart';

/// Renders a [ListingProvider]'s state as a list: a spinner while loading, a
/// friendly message when empty or on error, otherwise a `ListView.builder` of
/// tappable cards. Each screen supplies how a [Listing] becomes a list [card]
/// and (optionally) which [detail] page it opens on tap.
///
/// This centralises the loading/empty/error handling that the old screens
/// lacked, and removes the parallel `List<Widget>` + `setState`-in-a-loop
/// pattern they all copied.
class ListingListView extends StatelessWidget {
  const ListingListView({
    super.key,
    required this.card,
    this.detail,
    this.padding,
  });

  /// Builds the card shown in the list for a listing.
  final Widget Function(BuildContext context, Listing listing) card;

  /// Builds the page pushed when a card is tapped. If null, cards are not
  /// tappable (callers can bake navigation into [card] instead).
  final Widget Function(BuildContext context, Listing listing)? detail;

  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ListingProvider>();

    switch (provider.status) {
      case ListingStatus.idle:
      case ListingStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case ListingStatus.error:
        return _Message(text: 'bilgiYuklenemedi'.tr());
      case ListingStatus.empty:
        return _Message(text: 'kayitBulunamadi'.tr());
      case ListingStatus.loaded:
        final items = provider.items;
        return ListView.builder(
          padding: padding,
          itemCount: items.length,
          itemBuilder: (context, index) {
            final listing = items[index];
            final cardWidget = card(context, listing);
            if (detail == null) return cardWidget;
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => detail!(context, listing),
                  ),
                );
              },
              child: cardWidget,
            );
          },
        );
    }
  }
}

class _Message extends StatelessWidget {
  const _Message({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextFonts.instance.explanationTextBold.copyWith(
            color: ColorConstants.instance.commentColor,
          ),
        ),
      ),
    );
  }
}
