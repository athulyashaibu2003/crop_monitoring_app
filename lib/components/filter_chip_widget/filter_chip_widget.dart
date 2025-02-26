import 'package:flutter/material.dart';

class FilterChipWidget extends StatelessWidget {
  final String label;
  FilterChipWidget({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Chip(
        label: Text(label),
        avatar: Icon(Icons.local_florist, size: 16),
      ),
    );
  }
}