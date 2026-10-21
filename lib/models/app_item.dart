import 'package:flutter/material.dart';

class MacAppItem {
  final String id;
  final String name;
  final String category;
  final IconData iconData;
  final Color iconColor;
  final String packageName;
  final bool isDockItem;

  const MacAppItem({
    required this.id,
    required this.name,
    required this.category,
    required this.iconData,
    required this.iconColor,
    required this.packageName,
    this.isDockItem = false,
  });
}
