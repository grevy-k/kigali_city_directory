import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../../providers/listing_provider.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ListingProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(18, MediaQuery.of(context).padding.top + 16, 18, 20),
            decoration: const BoxDecoration(
              color: Color(0xFF00695C),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
            ),
            child: const Text(
              'Map View',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: FlutterMap(
                  options: const MapOptions(
                    initialCenter: LatLng(-1.9441, 30.0619),
                    initialZoom: 13,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.kigali_city_directory',
                    ),
                    MarkerLayer(
                      markers: provider.filtered.map((item) {
                        return Marker(
                          point: LatLng(
                            item.location.latitude,
                            item.location.longitude,
                          ),
                          width: 44,
                          height: 44,
                          child: const Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 36,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}