import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/sample_listings.dart';
import '../models/listing.dart';

class ListingService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Listing>> streamAll() {
    return _db
        .collection('listings')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Listing.fromDoc(doc)).toList();
    });
  }

  Stream<List<Listing>> streamMine(String uid) {
    return _db
        .collection('listings')
        .where('createdBy', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Listing.fromDoc(doc)).toList();
    });
  }

  Future<void> create(Listing listing) async {
    await _db.collection('listings').add(listing.toMap());
  }

  Future<void> update(Listing listing) async {
    await _db.collection('listings').doc(listing.id).update(listing.toMap());
  }

  Future<void> delete(String id) async {
    await _db.collection('listings').doc(id).delete();
  }

  Future<void> seedSampleListings({required String uid}) async {
    final listingsRef = _db.collection('listings');

    final existing = await listingsRef.limit(1).get();
    if (existing.docs.isNotEmpty) return;

    final batch = _db.batch();

    for (final item in SampleListingData.items) {
      final doc = listingsRef.doc();

      batch.set(doc, {
        'name': item['name'],
        'category': item['category'],
        'address': item['address'],
        'phone': item['phone'],
        'description': item['description'],
        'location': GeoPoint(item['latitude'], item['longitude']),
        'createdBy': uid,
        'createdAt': Timestamp.now(),
        'updatedAt': Timestamp.now(),
        'imageUrl': item['imageUrl'] ?? '',
      });
    }

    await batch.commit();
  }
}