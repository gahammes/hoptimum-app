import 'package:flutter/material.dart';

class Solicitacao {
  final String id;
  final String title;
  final String tipo;
  final Color color;

  const Solicitacao({
    required this.id,
    required this.title,
    required this.tipo,
    this.color = Colors.red,
  });
}
