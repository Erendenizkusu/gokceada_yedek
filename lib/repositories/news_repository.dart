import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/news_item.dart';

/// Reads the `news` collection used by the home screen carousel. Only active
/// items are returned, newest first.
class NewsRepository {
  NewsRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Future<List<NewsItem>> fetchActive() async {
    final snapshot = await _firestore
        .collection('news')
        .where('isActive', isEqualTo: true)
        .orderBy('publishedAt', descending: true)
        .get();
    return snapshot.docs.map(NewsItem.fromDoc).toList();
  }
}
