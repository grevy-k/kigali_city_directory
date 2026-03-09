import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/listing.dart';
import '../../providers/auth_provider.dart';
import '../../providers/listing_provider.dart';
import '../../services/location_service.dart';

class UpsertListingScreen extends StatefulWidget {
  final Listing? listing;

  const UpsertListingScreen({super.key, this.listing});

  @override
  State<UpsertListingScreen> createState() => _UpsertListingScreenState();
}

class _UpsertListingScreenState extends State<UpsertListingScreen> {
  final formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();
  final latCtrl = TextEditingController();
  final lngCtrl = TextEditingController();

  String selectedCategory = 'Hospital';
  bool saving = false;

  final categories = const [
    'Hospital',
    'Police',
    'Library',
    'Restaurant',
    'Café',
    'Park',
    'Tourist',
  ];

  @override
  void initState() {
    super.initState();

    final item = widget.listing;
    if (item != null) {
      nameCtrl.text = item.name;
      addressCtrl.text = item.address;
      phoneCtrl.text = item.phone;
      descriptionCtrl.text = item.description;
      latCtrl.text = item.location.latitude.toString();
      lngCtrl.text = item.location.longitude.toString();
      selectedCategory = item.category;
    }
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    addressCtrl.dispose();
    phoneCtrl.dispose();
    descriptionCtrl.dispose();
    latCtrl.dispose();
    lngCtrl.dispose();
    super.dispose();
  }

  Future<void> useMyLocation() async {
    try {
      final position = await LocationService().getCurrentPosition();
      latCtrl.text = position.latitude.toString();
      lngCtrl.text = position.longitude.toString();
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  Future<void> saveListing() async {
    if (!formKey.currentState!.validate()) return;

    setState(() {
      saving = true;
    });

    try {
      final auth = context.read<AuthProvider>();
      final provider = context.read<ListingProvider>();

      final item = Listing(
        id: widget.listing?.id ?? '',
        name: nameCtrl.text.trim(),
        category: selectedCategory,
        address: addressCtrl.text.trim(),
        phone: phoneCtrl.text.trim(),
        description: descriptionCtrl.text.trim(),
        location: GeoPoint(
          double.parse(latCtrl.text.trim()),
          double.parse(lngCtrl.text.trim()),
        ),
        createdBy: widget.listing?.createdBy ?? auth.user!.uid,
        createdAt: widget.listing?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );

      if (widget.listing == null) {
        await provider.create(item);
      } else {
        await provider.update(item);
      }

      if (mounted) Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save: $e')),
      );
    }

    if (mounted) {
      setState(() {
        saving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.listing != null;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Listing' : 'Add Listing'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 30),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              _card(
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameCtrl,
                      decoration: const InputDecoration(
                        hintText: 'Place or service name',
                        prefixIcon: Icon(Icons.place_outlined),
                      ),
                      validator: (value) =>
                          value == null || value.trim().isEmpty ? 'Enter name' : null,
                    ),
                    const SizedBox(height: 14),
                    DropdownButtonFormField<String>(
                      value: selectedCategory,
                      items: categories
                          .map(
                            (cat) => DropdownMenuItem(
                              value: cat,
                              child: Text(cat),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedCategory = value;
                          });
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: 'Category',
                        prefixIcon: Icon(Icons.category_outlined),
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: addressCtrl,
                      decoration: const InputDecoration(
                        hintText: 'Address',
                        prefixIcon: Icon(Icons.home_work_outlined),
                      ),
                      validator: (value) =>
                          value == null || value.trim().isEmpty ? 'Enter address' : null,
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: phoneCtrl,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: 'Contact number',
                        prefixIcon: Icon(Icons.phone_outlined),
                      ),
                      validator: (value) =>
                          value == null || value.trim().isEmpty ? 'Enter phone number' : null,
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: descriptionCtrl,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        hintText: 'Description',
                        prefixIcon: Icon(Icons.description_outlined),
                      ),
                      validator: (value) =>
                          value == null || value.trim().isEmpty ? 'Enter description' : null,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _card(
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Location',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        const Spacer(),
                        TextButton.icon(
                          onPressed: useMyLocation,
                          icon: const Icon(Icons.my_location),
                          label: const Text('Use my location'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: latCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Latitude',
                        prefixIcon: Icon(Icons.pin_drop_outlined),
                      ),
                      validator: (value) =>
                          value == null || value.trim().isEmpty ? 'Enter latitude' : null,
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: lngCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Longitude',
                        prefixIcon: Icon(Icons.explore_outlined),
                      ),
                      validator: (value) =>
                          value == null || value.trim().isEmpty ? 'Enter longitude' : null,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: saving ? null : saveListing,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0A2342),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: saving
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          isEdit ? 'Update Listing' : 'Save Listing',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
              ),
              if (isEdit) ...[
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton(
                    onPressed: () async {
                      await context.read<ListingProvider>().delete(widget.listing!.id);
                      if (mounted) Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                    ),
                    child: const Text('Delete Listing'),
                  ),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 14,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}