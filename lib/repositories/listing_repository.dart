import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/listing.dart';

/// Reads the category listing collections (restaurantList, hotelList, ...)
/// from Firestore and maps each document into a typed [Listing].
///
/// This replaces the old per-screen pattern where every `*Map.dart` screen
/// duplicated a `FirebaseFirestore.instance.collection(...).get().then(...)`
/// block and pushed widgets into parallel `List<Widget>`s inside a loop.
class ListingRepository {
  ListingRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  /// Fetches every document in [collection], mapping the display name from
  /// [nameKey] (e.g. `restaurant_name`, `hotel_name`, `barName`).
  Future<List<Listing>> fetch(
    String collection, {
    required String nameKey,
  }) async {
    final snapshot = await _firestore.collection(collection).get();
    return snapshot.docs
        .map((doc) => Listing.fromDoc(doc, nameKey: nameKey))
        .toList();
  }
}
