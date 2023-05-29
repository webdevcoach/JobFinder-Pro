import 'package:flutter/material.dart';

Widget PerkChips(String chipName, List chipNames, void Function()? onTap) {
  final isSelected = chipNames.contains(chipName);

  return GestureDetector(
    onTap: onTap,
    child: Chip(
      label: Text(chipName),
      backgroundColor: isSelected ? Colors.blue : null,
    ),
  );
}
