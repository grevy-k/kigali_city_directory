import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../providers/listing_provider.dart';
import '../directory/directory_screen.dart';
import '../map/map_screen.dart';
import '../my_listings/my_listings_screen.dart';
import '../settings/settings_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int currentIndex = 0;
  bool _started = false;

  final List<Widget> pages = const [
    DirectoryScreen(),
    MyListingsScreen(),
    MapScreen(),
    SettingsScreen(),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_started) return;

    final auth = context.read<AuthProvider>();
    final listings = context.read<ListingProvider>();

    if (auth.user != null) {
      listings.startStreams(uid: auth.user!.uid);
      listings.seedSampleListings(auth.user!.uid);
      _started = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF00695C),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black12,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            backgroundColor: const Color(0xFF00695C),
            selectedItemColor: const Color(0xFF26C6DA),
            unselectedItemColor: Colors.white70,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            onTap: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.grid_view_rounded),
                label: 'Directory',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_border_rounded),
                label: 'My Listings',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map_outlined),
                label: 'Map',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}