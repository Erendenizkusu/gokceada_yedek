import 'package:flutter/foundation.dart';

import '../models/news_item.dart';
import '../repositories/news_repository.dart';

enum NewsStatus { idle, loading, loaded, empty, error }

/// Owns the state of the home screen news carousel. Loaded once at app start
/// (see `main.dart`) and exposed to the home screen via `provider`.
class NewsProvider extends ChangeNotifier {
  NewsProvider({NewsRepository? repository})
      : _repository = repository ?? NewsRepository();

  final NewsRepository _repository;

  NewsStatus _status = NewsStatus.idle;
  List<NewsItem> _items = const [];
  Object? _error;

  NewsStatus get status => _status;
  List<NewsItem> get items => _items;
  Object? get error => _error;

  bool get hasNews => _items.isNotEmpty;

  Future<void> load() async {
    _status = NewsStatus.loading;
    _error = null;
    notifyListeners();
    try {
      final result = await _repository.fetchActive();
      _items = result;
      _status = result.isEmpty ? NewsStatus.empty : NewsStatus.loaded;
    } catch (e) {
      _error = e;
      _items = const [];
      _status = NewsStatus.error;
    }
    notifyListeners();
  }
}
