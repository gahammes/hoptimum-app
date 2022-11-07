import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  final String tipo;
  final Color color;

  const Category({
    required this.id,
    required this.title,
    required this.tipo,
    this.color = Colors.red,
  });
}
