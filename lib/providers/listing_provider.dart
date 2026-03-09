import 'dart:async';

import 'package:flutter/material.dart';

import '../models/listing.dart';
import '../services/listing_service.dart';

class ListingProvider extends ChangeNotifier {
  final ListingService _service = ListingService();

  List<Listing> _all = [];
  List<Listing> _mine = [];

  String _search = '';
  String _category = 'All';

  bool isLoading = false;
  String? error;

  StreamSubscription<List<Listing>>? _allSub;
  StreamSubscription<List<Listing>>? _mineSub;

  List<Listing> get filtered {
    final query = _search.trim().toLowerCase();

    return _all.where((listing) {
      final matchesSearch =
          query.isEmpty || listing.name.toLowerCase().contains(query);

      final matchesCategory =
          _category == 'All' || listing.category == _category;

      return matchesSearch && matchesCategory;
    }).toList();
  }

  List<Listing> get mine => _mine;
  String get category => _category;
  String get search => _search;

  void startStreams({required String uid}) {
    _allSub?.cancel();
    _mineSub?.cancel();

    _allSub = _service.streamAll().listen((items) {
      _all = items;
      notifyListeners();
    });

    _mineSub = _service.streamMine(uid).listen((items) {
      _mine = items;
      notifyListeners();
    });
  }

  void setSearch(String value) {
    _search = value;
    notifyListeners();
  }

  void setCategory(String value) {
    _category = value;
    notifyListeners();
  }

  Future<void> create(Listing listing) async {
    await _service.create(listing);
  }

  Future<void> update(Listing listing) async {
    await _service.update(listing);
  }

  Future<void> delete(String id) async {
    await _service.delete(id);
  }

  Future<void> seedSampleListings(String uid) async {
    try {
      error = null;
      await _service.seedSampleListings(uid: uid);
      notifyListeners();
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _allSub?.cancel();
    _mineSub?.cancel();
    super.dispose();
  }
}