import 'package:flutter/material.dart';

class ColorDot extends StatelessWidget {
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const ColorDot({
    super.key,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: isSelected ? Border.all(color: Colors.white, width: 3) : null,
        ),
        child: isSelected
            ? const Icon(
          Icons.check,
          size: 16,
          color: Colors.white,
        )
            : null,
      ),
    );
  }
}