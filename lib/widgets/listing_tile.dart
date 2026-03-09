import 'package:flutter/material.dart';

import '../models/listing.dart';
import '../screens/directory/listing_detail_screen.dart';

class ListingTile extends StatelessWidget {
  final Listing listing;

  const ListingTile({
    super.key,
    required this.listing,
  });

  IconData _iconForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'hospital':
        return Icons.local_hospital_rounded;
      case 'police':
        return Icons.local_police_rounded;
      case 'library':
        return Icons.local_library_rounded;
      case 'restaurant':
        return Icons.restaurant_rounded;
      case 'café':
      case 'cafe':
        return Icons.local_cafe_rounded;
      case 'park':
        return Icons.park_rounded;
      case 'tourist':
        return Icons.camera_alt_rounded;
      default:
        return Icons.place_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final lat = listing.location.latitude;
    final lng = listing.location.longitude;
    final fakeDistance = ((lat.abs() + lng.abs()) % 2.3 + 0.4).toStringAsFixed(1);

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ListingDetailScreen(listing: listing),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 14,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: const Color(0xFFEAF1FF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                _iconForCategory(listing.category),
                color: const Color(0xFF0A2342),
                size: 28,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    listing.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF202430),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    listing.category,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, color: Color(0xFFF4C542), size: 18),
                      const SizedBox(width: 2),
                      const Icon(Icons.star_rounded, color: Color(0xFFF4C542), size: 18),
                      const SizedBox(width: 2),
                      const Icon(Icons.star_rounded, color: Color(0xFFF4C542), size: 18),
                      const SizedBox(width: 2),
                      const Icon(Icons.star_rounded, color: Color(0xFFF4C542), size: 18),
                      const SizedBox(width: 2),
                      Icon(Icons.star_rounded, color: Colors.grey.shade300, size: 18),
                      const SizedBox(width: 10),
                      Text(
                        '$fakeDistance km',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Colors.black45,
            ),
          ],
        ),
      ),
    );
  }
}