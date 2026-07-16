import 'package:flutter/foundation.dart';

import '../models/listing.dart';
import '../repositories/listing_repository.dart';

enum ListingStatus { idle, loading, loaded, empty, error }

/// Holds the state for a single category listing screen. Each `*Map.dart`
/// screen creates one of these (scoped via `ChangeNotifierProvider`) and calls
/// [load] once. The screen then reacts to [status]/[items] instead of building
/// and storing widgets by hand.
class ListingProvider extends ChangeNotifier {
  ListingProvider({ListingRepository? repository})
      : _repository = repository ?? ListingRepository();

  final ListingRepository _repository;

  ListingStatus _status = ListingStatus.idle;
  List<Listing> _items = const [];
  Object? _error;

  ListingStatus get status => _status;
  List<Listing> get items => _items;
  Object? get error => _error;

  bool get isLoading => _status == ListingStatus.loading;
  bool get hasError => _status == ListingStatus.error;
  bool get isEmpty => _status == ListingStatus.empty;

  Future<void> load(String collection, {required String nameKey}) async {
    _status = ListingStatus.loading;
    _error = null;
    notifyListeners();
    try {
      final result = await _repository.fetch(collection, nameKey: nameKey);
      _items = result;
      _status = result.isEmpty ? ListingStatus.empty : ListingStatus.loaded;
    } catch (e) {
      _error = e;
      _items = const [];
      _status = ListingStatus.error;
    }
    notifyListeners();
  }
}
