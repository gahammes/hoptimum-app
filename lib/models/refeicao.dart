enum Preco { razoavel, barato, caro }

class Refeicao {
  final String id;
  final List<String> categories;
  final String title;
  final String imageUrl;
  final int duration;
  final double price;
  final Preco affordability;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;

  const Refeicao({
    required this.id,
    required this.title,
    required this.categories,
    required this.imageUrl,
    required this.duration,
    required this.price,
    required this.affordability,
    required this.isGlutenFree,
    required this.isLactoseFree,
    required this.isVegan,
    required this.isVegetarian,
  });
}
