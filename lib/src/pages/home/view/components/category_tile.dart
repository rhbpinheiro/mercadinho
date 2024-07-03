// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  final String category;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: BoxDecoration(
            color: isSelected ? Colors.green : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            category,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.orangeAccent,
              fontWeight: FontWeight.bold,
              fontSize: isSelected ? 16 : 14,
            ),
          ),
        ),
      ),
    );
  }
}
