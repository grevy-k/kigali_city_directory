import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/listing_provider.dart';
import '../../widgets/listing_tile.dart';
import 'upsert_listing_screen.dart';

class MyListingsScreen extends StatelessWidget {
  const MyListingsScreen({super.key});

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
              'My Listings',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: provider.mine.isEmpty
                ? const Center(
                    child: Text(
                      'No listings yet',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 18, 16, 100),
                    itemCount: provider.mine.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: ListingTile(listing: provider.mine[index]),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF00695C),
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const UpsertListingScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}