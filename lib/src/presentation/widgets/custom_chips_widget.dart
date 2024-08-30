import 'package:flutter/material.dart';

class CustomChips extends StatelessWidget {
  final String title;
  final List<String> options;
  final List<String> selectedChips;
  final ValueChanged<List<String>> onSelectionChanged;
  final bool isSingleSelection; // Add this boolean flag

  const CustomChips({
    Key? key,
    required this.title,
    required this.options,
    required this.selectedChips,
    required this.onSelectionChanged,
    this.isSingleSelection = false, // Set a default value for isSingleSelection
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Wrap(
          spacing: 8,
          children: options.map((option) {
            return ChoiceChip(
              label: Text(option.toUpperCase()),
              selected: selectedChips.contains(option),
              selectedColor: const Color.fromARGB(255, 157, 214, 255),
              onSelected: (selected) {
                if (isSingleSelection) {
                  // Clear the selectedChips list before adding the new selection
                  selectedChips.clear();
                }
                if (selected) {
                  selectedChips.add(option);
                } else {
                  selectedChips.remove(option);
                }
                onSelectionChanged(List.from(selectedChips));
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
