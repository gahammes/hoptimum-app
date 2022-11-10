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

const refeicoesCategories = [
  //DUMMY_CATEGORIES
  Category(
    id: 'c100',
    title: 'Café da Manhã',
    tipo: 'ref',
    color: Colors.red,
  ),
  Category(
    id: 'c200',
    title: 'Almoço',
    tipo: 'ref',
    color: Colors.red,
  ),
  Category(
    id: 'c300',
    title: 'Jantar',
    tipo: 'ref',
    color: Colors.red,
  ),
  Category(
    id: 's1',
    title: 'Serviço de quarto',
    tipo: 'serv',
    color: Colors.red,
  ),
];
