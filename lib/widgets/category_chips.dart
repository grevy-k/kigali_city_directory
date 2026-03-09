import 'package:flutter/material.dart';

const List<String> kCategories = [
  'Hospital',
  'Police',
  'Library',
  'Restaurant',
  'Café',
  'Park',
  'Tourist',
];

class CategoryChips extends StatelessWidget {
  final String? selected;
  final void Function(String?) onSelected;

  const CategoryChips({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          FilterChip(
            label: const Text('All'),
            selected: selected == null,
            onSelected: (_) => onSelected(null),
          ),
          const SizedBox(width: 8),
          ...kCategories.map(
            (cat) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(cat),
                selected: selected == cat,
                onSelected: (picked) => onSelected(picked ? cat : null),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
