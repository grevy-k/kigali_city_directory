import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../providers/listing_provider.dart';
import '../../widgets/listing_tile.dart';

class DirectoryScreen extends StatelessWidget {
  const DirectoryScreen({super.key});

  static const List<String> categories = [
    'All',
    'Hospital',
    'Police',
    'Library',
    'Restaurant',
    'Café',
    'Park',
    'Tourist',
  ];

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ListingProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(18, MediaQuery.of(context).padding.top + 16, 18, 20),
            decoration: const BoxDecoration(
              color: Color(0xFF00695C),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.location_on_rounded, color: Colors.white, size: 20),
                    SizedBox(width: 6),
                    Text(
                      'Kigali City',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                SizedBox(
                  height: 42,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final selected = provider.category == category;

                      return GestureDetector(
                        onTap: () => provider.setCategory(category),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 220),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: selected ? const Color(0xFF26C6DA) : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            category,
                            style: TextStyle(
                              color: selected ? const Color(0xFF00695C) : Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  height: 52,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextField(
                    onChanged: provider.setSearch,
                    decoration: const InputDecoration(
                      hintText: 'Search for service or place',
                      prefixIcon: Icon(Icons.search_rounded),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: provider.filtered.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.location_city_rounded,
                            size: 60,
                            color: Colors.black26,
                          ),
                          const SizedBox(height: 14),
                          const Text(
                            'No listings found',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Load sample Kigali places so your directory starts with real content.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black54,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 18),
                          ElevatedButton(
                            onPressed: () async {
                              final uid = context.read<AuthProvider>().user!.uid;
                              await context
                                  .read<ListingProvider>()
                                  .seedSampleListings(uid);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0A2342),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 22,
                                vertical: 14,
                              ),
                            ),
                            child: const Text('Load Sample Data'),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView(
                    padding: const EdgeInsets.fromLTRB(16, 18, 16, 90),
                    children: [
                      const Text(
                        'Near You',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1B1E28),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...provider.filtered.map(
                        (listing) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: ListingTile(listing: listing),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}