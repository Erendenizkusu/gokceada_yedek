import 'package:cloud_firestore/cloud_firestore.dart';

/// A single business/place document from one of the Firestore listing
/// collections (restaurantList, hotelList, pansionList, ...).
///
/// The collections were authored independently and use slightly different
/// field names for the display name (`restaurant_name`, `hotel_name`,
/// `barName`, ...), so [Listing.fromDoc] takes a [nameKey] to map the right
/// field. All reads are defensive: a missing or wrongly-typed field falls back
/// to a sensible empty value instead of throwing, which the old inline
/// `doc['field']` reads did not do.
class Listing {
  const Listing({
    required this.id,
    required this.name,
    required this.image,
    required this.location,
    required this.rating,
    required this.reviewCount,
    required this.placeId,
    required this.telNo,
    required this.link,
    required this.latLng,
    required this.description,
    required this.icons,
    required this.owner,
    required this.info,
    required this.raw,
  });

  final String id;
  final String name;
  final String image;
  final String location;

  /// Place rating (e.g. "4.7"). Now sourced from Google Places API and cached
  /// in Firestore by the `refresh_ratings.js` script — no longer hand-entered.
  final String rating;

  /// Number of Google reviews (`user_ratings_total`), cached from Places.
  /// Shown as "(N yorum)" next to the rating; 0 hides the count.
  final int reviewCount;

  /// Google Place ID used by the refresh script to fetch [rating]/[reviewCount].
  /// Resolved automatically from the venue name on first run and cached here.
  final String placeId;

  final String telNo;
  final String link;
  final List<double> latLng;
  final String description;
  final List<String> icons;
  final String owner;
  final List<String> info;

  /// Whether this listing has a usable numeric rating to display.
  bool get hasRating {
    final r = double.tryParse(rating);
    return r != null && r > 0;
  }

  /// The raw document data, kept for the few screens that read collection
  /// specific shapes (e.g. `activitiesList` stores `owner`/`telNo` as arrays).
  final Map<String, dynamic> raw;

  double get latitude => latLng.isNotEmpty ? latLng[0] : 0;
  double get longitude => latLng.length > 1 ? latLng[1] : 0;

  /// Some collections (e.g. `activitiesList`) store `telNo`/`owner` as arrays.
  /// These expose the raw list form for the screens that need every entry.
  List<String> get telNoList => _strList(raw['telNo']);
  List<String> get ownerList => _strList(raw['owner']);

  factory Listing.fromDoc(
    DocumentSnapshot doc, {
    required String nameKey,
  }) {
    final data = (doc.data() as Map<String, dynamic>?) ?? const {};
    return Listing(
      id: doc.id,
      name: _str(data[nameKey]),
      image: _str(data['image']),
      location: _str(data['location']),
      rating: _str(data['rating']),
      reviewCount: _int(data['reviewCount']),
      placeId: _str(data['placeId']),
      telNo: _firstOrStr(data['telNo']),
      link: _str(data['link']),
      latLng: _doubleList(data['latLng']),
      description: _str(data['description']),
      icons: _strList(data['icon']),
      owner: _firstOrStr(data['owner']),
      info: _strList(data['info']),
      raw: data,
    );
  }

  static String _str(dynamic value) => value == null ? '' : value.toString();

  static int _int(dynamic value) {
    if (value is num) return value.toInt();
    return int.tryParse('$value') ?? 0;
  }

  /// Some collections store `telNo`/`owner` as a single string, others as a
  /// list. Return the first entry as a string in either case.
  static String _firstOrStr(dynamic value) {
    if (value is List) return value.isEmpty ? '' : value.first.toString();
    return _str(value);
  }

  static List<String> _strList(dynamic value) {
    if (value is List) return value.map((e) => e.toString()).toList();
    return const [];
  }

  static List<double> _doubleList(dynamic value) {
    if (value is List) {
      return value
          .map((e) => e is num ? e.toDouble() : double.tryParse('$e') ?? 0)
          .toList();
    }
    return const [];
  }
}
