import 'package:cloud_firestore/cloud_firestore.dart';

/// A single news entry shown in the home screen carousel. Documents live in the
/// Firestore `news` collection and are authored by hand from the Firebase
/// Console.
///
/// Expected document shape:
/// ```
/// {
///   "title":       string,   // headline shown on the card
///   "subtitle":    string,   // optional secondary line
///   "imageUrl":    string,   // external image URL (network)
///   "linkUrl":     string,   // opened in an in-app WebView on tap
///   "isActive":    bool,     // only true items are shown
///   "publishedAt": timestamp // newest first
/// }
/// ```
class NewsItem {
  const NewsItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.linkUrl,
    required this.publishedAt,
  });

  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String linkUrl;
  final DateTime? publishedAt;

  bool get hasLink => linkUrl.trim().isNotEmpty;

  factory NewsItem.fromDoc(DocumentSnapshot doc) {
    final data = (doc.data() as Map<String, dynamic>?) ?? const {};
    final rawDate = data['publishedAt'];
    return NewsItem(
      id: doc.id,
      title: (data['title'] ?? '').toString(),
      subtitle: (data['subtitle'] ?? '').toString(),
      imageUrl: (data['imageUrl'] ?? '').toString(),
      linkUrl: (data['linkUrl'] ?? '').toString(),
      publishedAt: rawDate is Timestamp ? rawDate.toDate() : null,
    );
  }
}
