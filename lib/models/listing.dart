import 'package:cloud_firestore/cloud_firestore.dart';

class Listing {
  final String id;
  final String name;
  final String category;
  final String address;
  final String phone;
  final String description;
  final GeoPoint location;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  Listing({
    required this.id,
    required this.name,
    required this.category,
    required this.address,
    required this.phone,
    required this.description,
    required this.location,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() => {
        'name': name.trim(),
        'category': category,
        'address': address.trim(),
        'phone': phone.trim(),
        'description': description.trim(),
        'location': location,
        'createdBy': createdBy,
        'createdAt': Timestamp.fromDate(createdAt),
        'updatedAt': Timestamp.fromDate(updatedAt),
      };

  factory Listing.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Listing(
      id: doc.id,
      name: data['name'] ?? '',
      category: data['category'] ?? '',
      address: data['address'] ?? '',
      phone: data['phone'] ?? '',
      description: data['description'] ?? '',
      location: (data['location'] as GeoPoint?) ?? const GeoPoint(0, 0),
      createdBy: data['createdBy'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}